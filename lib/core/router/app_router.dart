import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/procedures/presentation/procedures_screen.dart';
import '../../features/procedures/presentation/life_stage_detail_screen.dart';
import '../../features/tasks/presentation/tasks_screen.dart';
import '../../shared/widgets/main_shell.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const ProceduresScreen(),
          ),
          GoRoute(
            path: '/tasks',
            name: 'tasks',
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: '/life-stage/:name',
            name: 'lifeStageDetail',
            builder: (context, state) {
              final lifeStage = state.pathParameters['name'] ?? '';
              return LifeStageDetailScreen(lifeStage: Uri.decodeComponent(lifeStage));
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'エラーが発生しました',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? '不明なエラー',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('ホームに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}