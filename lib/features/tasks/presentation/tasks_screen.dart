import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/task_provider.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/services/session_service.dart';
import '../../../core/services/supabase_service.dart';
import 'widgets/task_list_item.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  bool _isInitializing = false;
  StreamSubscription? _realtimeSubscription;

  @override
  void initState() {
    super.initState();
    // 初回アクセス時のタスク生成チェック
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndInitializeTasks();
      _setupRealtimeSubscription();
    });
  }

  @override
  void dispose() {
    _realtimeSubscription?.cancel();
    super.dispose();
  }

  Future<void> _setupRealtimeSubscription() async {
    final sessionId = await ref.read(sessionIdProvider.future);
    
    _realtimeSubscription = SupabaseService.subscribeToTasks(sessionId)
        .listen((data) {
      // タスクが更新されたらプロバイダーを更新
      ref.invalidate(tasksProvider);
    });
  }

  Future<void> _checkAndInitializeTasks() async {
    final tasks = await ref.read(tasksProvider.future);
    
    if (tasks.isEmpty && !_isInitializing) {
      setState(() {
        _isInitializing = true;
      });
      
      // 初回アクセス時は全タスクを自動生成
      final initialize = ref.read(initializeSessionProvider);
      final success = await initialize();
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('タスクリストを初期化しました')),
        );
      }
      
      setState(() {
        _isInitializing = false;
      });
    }
  }

  void _showShareDialog(String sessionId) {
    final shareUrl = SessionService.generateShareUrl(sessionId);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('共有URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('このURLを家族と共有すると、同じタスクリストを見ることができます：'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                shareUrl,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);
    final sessionIdAsync = ref.watch(sessionIdProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('タスクリスト'),
        actions: [
          sessionIdAsync.when(
            data: (sessionId) => IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _showShareDialog(sessionId),
              tooltip: '共有',
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: _isInitializing
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('タスクリストを準備中...'),
                  ],
                ),
              )
            : tasksAsync.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text('タスクがありません', style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _checkAndInitializeTasks,
                            child: const Text('タスクを初期化'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // ライフステージごとにグループ化
                  final tasksByLifeStage = <String, List<dynamic>>{};
                  for (final task in tasks) {
                    if (task.procedure != null) {
                      tasksByLifeStage.putIfAbsent(
                        task.procedure!.lifeStage,
                        () => [],
                      ).add(task);
                    }
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(tasksProvider);
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: tasksByLifeStage.length,
                      itemBuilder: (context, index) {
                        final lifeStage = tasksByLifeStage.keys.elementAt(index);
                        final stageTasks = tasksByLifeStage[lifeStage]!;
                        final completedCount = stageTasks.where((t) => t.status == 'completed').length;
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ExpansionTile(
                            title: Text(
                              lifeStage,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: Text('完了: $completedCount / ${stageTasks.length}'),
                            initiallyExpanded: index == 0,
                            children: stageTasks.map((task) {
                              return TaskListItem(
                                task: task,
                                onStatusChanged: (status) async {
                                  final updateStatus = ref.read(updateTaskStatusProvider);
                                  await updateStatus(task.id, status);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('エラーが発生しました', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(error.toString()),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(tasksProvider),
                        child: const Text('再読み込み'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}