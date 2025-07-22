import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/life_stage.dart';
import 'widgets/life_stage_card.dart';

class ProceduresScreen extends ConsumerWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Supabaseから取得するように変更
    final lifeStages = _mockLifeStages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('みちしるべ'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '手続きの流れ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '各ステージの手続きを確認し、必要なものをタスクリストに追加しましょう',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: lifeStages.length,
                  itemBuilder: (context, index) {
                    return LifeStageCard(
                      lifeStage: lifeStages[index],
                      onTap: () {
                        // TODO: 詳細画面への遷移
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${lifeStages[index].name}の詳細画面は準備中です'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Supabaseから取得するまでの仮データ
final _mockLifeStages = [
  LifeStage(
    id: '1',
    name: '入院準備',
    description: '入院に必要な手続きと準備',
    iconName: 'local_hospital',
    order: 1,
    completedCount: 0,
    totalCount: 4,
  ),
  LifeStage(
    id: '2',
    name: '介護申請',
    description: '介護保険の申請と手続き',
    iconName: 'accessibility',
    order: 2,
    completedCount: 0,
    totalCount: 4,
  ),
  LifeStage(
    id: '3',
    name: '施設選び',
    description: '介護施設の選定と入居手続き',
    iconName: 'home',
    order: 3,
    completedCount: 0,
    totalCount: 4,
  ),
  LifeStage(
    id: '4',
    name: '看取り準備',
    description: '終末期の準備と意思確認',
    iconName: 'favorite',
    order: 4,
    completedCount: 0,
    totalCount: 4,
  ),
  LifeStage(
    id: '5',
    name: '相続手続き',
    description: '相続に関する各種手続き',
    iconName: 'description',
    order: 5,
    completedCount: 0,
    totalCount: 4,
  ),
];