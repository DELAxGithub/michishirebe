import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/procedure_provider.dart';
import '../../../core/providers/task_provider.dart';
import '../domain/life_stage.dart';
import '../data/life_stage_config.dart';

// ライフステージリストプロバイダー
final lifeStagesProvider = FutureProvider<List<LifeStage>>((ref) async {
  // 手続きとタスクを取得
  final procedures = await ref.watch(proceduresProvider.future);
  final tasks = await ref.watch(tasksProvider.future);
  
  // ライフステージごとに集計
  final lifeStageMap = <String, Map<String, dynamic>>{};
  
  // 手続き数をカウント
  for (final procedure in procedures) {
    lifeStageMap.putIfAbsent(procedure.lifeStage, () => {
      'totalCount': 0,
      'completedCount': 0,
    });
    lifeStageMap[procedure.lifeStage]!['totalCount'] = 
        (lifeStageMap[procedure.lifeStage]!['totalCount'] as int) + 1;
  }
  
  // 完了タスク数をカウント
  for (final task in tasks) {
    if (task.status == 'completed' && task.procedure != null) {
      final lifeStage = task.procedure!.lifeStage;
      lifeStageMap.putIfAbsent(lifeStage, () => {
        'totalCount': 0,
        'completedCount': 0,
      });
      lifeStageMap[lifeStage]!['completedCount'] = 
          (lifeStageMap[lifeStage]!['completedCount'] as int) + 1;
    }
  }
  
  // LifeStageオブジェクトを作成
  final lifeStages = <LifeStage>[];
  
  lifeStageMap.forEach((name, counts) {
    final config = LifeStageConfig.config[name];
    if (config != null) {
      lifeStages.add(LifeStage(
        id: name,
        name: name,
        description: config['description'] as String,
        iconName: config['iconName'] as String,
        order: config['order'] as int,
        totalCount: counts['totalCount'] as int,
        completedCount: counts['completedCount'] as int,
      ));
    }
  });
  
  // 順序でソート
  lifeStages.sort((a, b) => a.order.compareTo(b.order));
  
  return lifeStages;
});