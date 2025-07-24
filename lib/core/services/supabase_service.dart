import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/procedure.dart';
import '../models/task.dart';

class SupabaseService {
  static final _supabase = Supabase.instance.client;

  // 手続き一覧を取得
  static Future<List<Procedure>> getProcedures() async {
    try {
      final response = await _supabase
          .from('michi_procedures')
          .select()
          .order('order_index');

      return (response as List)
          .map((json) => Procedure.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching procedures: $e');
      return [];
    }
  }

  // セッションのタスク一覧を取得（手続き情報付き）
  static Future<List<Task>> getTasks(String sessionId) async {
    try {
      final response = await _supabase
          .from('michi_tasks')
          .select('*, procedures:michi_procedures(*)')
          .eq('session_id', sessionId)
          .order('created_at');

      return (response as List)
          .map((json) => Task.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  // 新しいタスクを作成
  static Future<Task?> createTask(String sessionId, int procedureId) async {
    try {
      final response = await _supabase
          .from('michi_tasks')
          .insert({
            'session_id': sessionId,
            'procedure_id': procedureId,
            'status': 'pending',
          })
          .select('*, procedures:michi_procedures(*)')
          .single();

      return Task.fromJson(response);
    } catch (e) {
      print('Error creating task: $e');
      return null;
    }
  }

  // タスクのステータスを更新
  static Future<bool> updateTaskStatus(String taskId, String status) async {
    try {
      await _supabase
          .from('michi_tasks')
          .update({
            'status': status,
            'completed_at': status == 'completed' ? DateTime.now().toIso8601String() : null,
          })
          .eq('id', taskId);

      return true;
    } catch (e) {
      print('Error updating task status: $e');
      return false;
    }
  }

  // タスクのメモを更新
  static Future<bool> updateTaskNotes(String taskId, String notes) async {
    try {
      await _supabase
          .from('michi_tasks')
          .update({
            'notes': notes,
          })
          .eq('id', taskId);

      return true;
    } catch (e) {
      print('Error updating task notes: $e');
      return false;
    }
  }

  // タスクを削除
  static Future<bool> deleteTask(String taskId) async {
    try {
      await _supabase
          .from('michi_tasks')
          .delete()
          .eq('id', taskId);

      return true;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    }
  }

  // セッションの全タスクを初期化（手続きマスターから作成）
  static Future<bool> initializeSessionTasks(String sessionId) async {
    try {
      // 既存のタスクをチェック
      final existingTasks = await getTasks(sessionId);
      if (existingTasks.isNotEmpty) {
        return false; // すでにタスクがある場合は作成しない
      }

      // 全手続きを取得
      final procedures = await getProcedures();

      // バッチで全タスクを作成
      final tasks = procedures.map((procedure) => {
        'session_id': sessionId,
        'procedure_id': procedure.id,
        'status': 'pending',
      }).toList();

      await _supabase.from('michi_tasks').insert(tasks);

      return true;
    } catch (e) {
      print('Error initializing session tasks: $e');
      return false;
    }
  }

  // リアルタイム更新の購読
  static Stream<List<Map<String, dynamic>>> subscribeToTasks(String sessionId) {
    return _supabase
        .from('michi_tasks')
        .stream(primaryKey: ['id'])
        .eq('session_id', sessionId);
  }
}