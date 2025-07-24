import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/life_stage.dart';
import '../providers/life_stage_provider.dart';
import 'widgets/life_stage_card.dart';

class ProceduresScreen extends ConsumerWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifeStagesAsync = ref.watch(lifeStagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('みちしるべ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () => context.push('/tasks'),
            tooltip: 'タスクリスト',
          ),
        ],
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
                child: lifeStagesAsync.when(
                  data: (lifeStages) => GridView.builder(
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
                          context.push(
                            '/life-stage/${Uri.encodeComponent(lifeStages[index].name)}',
                          );
                        },
                      );
                    },
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
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
                          onPressed: () => ref.invalidate(lifeStagesProvider),
                          child: const Text('再読み込み'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}