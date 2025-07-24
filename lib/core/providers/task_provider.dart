import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../services/supabase_service.dart';
import 'session_provider.dart';

// タスクリストプロバイダー
final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final sessionId = await ref.watch(sessionIdProvider.future);
  return await SupabaseService.getTasks(sessionId);
});

// タスクの作成
final createTaskProvider = Provider<Future<Task?> Function(int)>((ref) {
  return (int procedureId) async {
    final sessionId = await ref.read(sessionIdProvider.future);
    final task = await SupabaseService.createTask(sessionId, procedureId);
    
    if (task != null) {
      // タスクリストを更新
      ref.invalidate(tasksProvider);
    }
    
    return task;
  };
});

// タスクステータスの更新
final updateTaskStatusProvider = Provider<Future<bool> Function(String, String)>((ref) {
  return (String taskId, String status) async {
    final success = await SupabaseService.updateTaskStatus(taskId, status);
    
    if (success) {
      // タスクリストを更新
      ref.invalidate(tasksProvider);
    }
    
    return success;
  };
});

// セッションの初期化（全タスク作成）
final initializeSessionProvider = Provider<Future<bool> Function()>((ref) {
  return () async {
    final sessionId = await ref.read(sessionIdProvider.future);
    final success = await SupabaseService.initializeSessionTasks(sessionId);
    
    if (success) {
      // タスクリストを更新
      ref.invalidate(tasksProvider);
    }
    
    return success;
  };
});

// タスクの削除
final deleteTaskProvider = Provider<Future<bool> Function(String)>((ref) {
  return (String taskId) async {
    final success = await SupabaseService.deleteTask(taskId);
    
    if (success) {
      // タスクリストを更新
      ref.invalidate(tasksProvider);
    }
    
    return success;
  };
});