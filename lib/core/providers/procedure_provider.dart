import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/procedure.dart';
import '../services/supabase_service.dart';

// 手続きリストプロバイダー
final proceduresProvider = FutureProvider<List<Procedure>>((ref) async {
  return await SupabaseService.getProcedures();
});

// ライフステージごとの手続きをグループ化
final proceduresByLifeStageProvider = Provider<Map<String, List<Procedure>>>((ref) {
  final proceduresAsync = ref.watch(proceduresProvider);
  
  return proceduresAsync.when(
    data: (procedures) {
      final grouped = <String, List<Procedure>>{};
      
      for (final procedure in procedures) {
        grouped.putIfAbsent(procedure.lifeStage, () => []).add(procedure);
      }
      
      return grouped;
    },
    loading: () => {},
    error: (_, __) => {},
  );
});