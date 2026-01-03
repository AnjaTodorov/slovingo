import 'package:flutter/material.dart';
import 'package:slovingo/models/level.dart';
import 'package:go_router/go_router.dart';

class LevelCard extends StatelessWidget {
  final Level level;

  const LevelCard({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: level.isLocked ? null : () {
        context.push('/level/${level.id}', extra: level);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: level.levelCategory == 'test'
              ? Theme.of(context).colorScheme.secondaryContainer
              : level.isLocked 
                  ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                  : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: level.isLocked
                ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.1)
                : level.levelCategory == 'test'
                    ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.4)
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: level.levelCategory == 'test'
                    ? Theme.of(context).colorScheme.secondary
                    : level.isLocked
                        ? Theme.of(context).colorScheme.surfaceContainerHighest
                        : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: level.isLocked
                    ? Icon(
                        Icons.lock,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                        size: 28,
                      )
                    : Text(
                        '${level.levelNumber}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: level.levelCategory == 'test'
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: level.isLocked
                          ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: level.isLocked
                          ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: level.levelCategory == 'test'
                          ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15)
                          : Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      level.levelCategory == 'test'
                          ? 'Test'
                          : level.levelCategory == 'quiz'
                              ? 'Quiz'
                              : 'Lesson',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: level.levelCategory == 'test'
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: level.isLocked
                  ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)
                  : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
