import 'package:flutter/material.dart';
import '../../domain/life_stage.dart';

class LifeStageCard extends StatelessWidget {
  final LifeStage lifeStage;
  final VoidCallback onTap;

  const LifeStageCard({
    super.key,
    required this.lifeStage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = lifeStage.totalCount > 0
        ? lifeStage.completedCount / lifeStage.totalCount
        : 0.0;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(lifeStage.iconName),
                size: 48,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                lifeStage.name,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${lifeStage.completedCount}/${lifeStage.totalCount}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: theme.colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'local_hospital':
        return Icons.local_hospital;
      case 'accessibility':
        return Icons.accessibility;
      case 'home':
        return Icons.home;
      case 'favorite':
        return Icons.favorite;
      case 'description':
        return Icons.description;
      default:
        return Icons.help_outline;
    }
  }
}