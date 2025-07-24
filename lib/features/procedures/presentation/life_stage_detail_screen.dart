import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/procedure_provider.dart';
import '../../../core/providers/task_provider.dart';
import '../../../core/models/procedure.dart';
import '../../../core/models/task.dart';

class LifeStageDetailScreen extends ConsumerWidget {
  final String lifeStage;

  const LifeStageDetailScreen({
    super.key,
    required this.lifeStage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proceduresAsync = ref.watch(proceduresProvider);
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(lifeStage),
      ),
      body: proceduresAsync.when(
        data: (allProcedures) {
          // このライフステージの手続きのみフィルタリング
          final procedures = allProcedures
              .where((p) => p.lifeStage == lifeStage)
              .toList();

          // カテゴリごとにグループ化
          final proceduresByCategory = <String, List<Procedure>>{};
          for (final procedure in procedures) {
            proceduresByCategory
                .putIfAbsent(procedure.category, () => [])
                .add(procedure);
          }

          return tasksAsync.when(
            data: (tasks) {
              // すでにタスクに追加されている手続きIDのセット
              final addedProcedureIds = tasks
                  .map((t) => t.procedureId)
                  .toSet();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: proceduresByCategory.length,
                itemBuilder: (context, index) {
                  final category = proceduresByCategory.keys.elementAt(index);
                  final categoryProcedures = proceduresByCategory[category]!;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...categoryProcedures.map((procedure) {
                            final isAdded = addedProcedureIds.contains(procedure.id);
                            
                            return _ProcedureListItem(
                              procedure: procedure,
                              isAdded: isAdded,
                              onToggle: () async {
                                if (isAdded) {
                                  // タスクから削除
                                  final taskToDelete = tasks.firstWhere(
                                    (t) => t.procedureId == procedure.id,
                                  );
                                  await ref.read(deleteTaskProvider)(taskToDelete.id);
                                } else {
                                  // タスクに追加
                                  await ref.read(createTaskProvider)(procedure.id);
                                }
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Text('エラー: $error'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('エラー: $error'),
        ),
      ),
    );
  }
}

class _ProcedureListItem extends StatelessWidget {
  final Procedure procedure;
  final bool isAdded;
  final VoidCallback onToggle;

  const _ProcedureListItem({
    required this.procedure,
    required this.isAdded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(procedure.priority);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showProcedureDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 優先度インジケーター
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              // 手続き情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      procedure.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (procedure.defaultDeadline != null && 
                        procedure.defaultDeadline != 'なし')
                      Text(
                        '期限: ${procedure.defaultDeadline}',
                        style: TextStyle(
                          color: priorityColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      procedure.reason,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // 追加/削除ボタン
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isAdded ? Icons.check_circle : Icons.add_circle_outline,
                  color: isAdded ? Colors.green : Colors.grey,
                  size: 28,
                ),
                tooltip: isAdded ? 'タスクから削除' : 'タスクに追加',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showProcedureDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      procedure.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildDetailSection('理由・説明', procedure.reason),
              
              if (procedure.hint != null)
                _buildDetailSection('ヒント', procedure.hint!),
              
              if (procedure.requiredDocuments.isNotEmpty)
                _buildDetailSection(
                  '必要書類',
                  procedure.requiredDocuments.join('\n'),
                ),
              
              if (procedure.defaultDeadline != null && 
                  procedure.defaultDeadline != 'なし')
                _buildDetailSection('期限', procedure.defaultDeadline!),
              
              if (procedure.responsibleOffice != null)
                _buildDetailSection('担当窓口', procedure.responsibleOffice!),
              
              const SizedBox(height: 24),
              
              ElevatedButton.icon(
                onPressed: onToggle,
                icon: Icon(
                  isAdded ? Icons.check_circle : Icons.add_circle_outline,
                ),
                label: Text(
                  isAdded ? 'タスクから削除' : 'タスクに追加',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAdded ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}