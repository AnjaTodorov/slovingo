import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';

class TrophiesScreen extends StatelessWidget {
  const TrophiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final user = provider.currentUser;
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return FutureBuilder<Map<String, dynamic>>(
              future: provider.getUserStatistics(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final stats = snapshot.data!;
                final completedLevels = stats['completedLevels'] as int? ?? 0;
                final totalPoints = user.totalPoints;
                final streak = user.streak;
                final translationCount = provider.translationHistory.length;

                final trophies = [
                  _Trophy(
                    title: 'First Steps',
                    description: 'Complete your first level',
                    icon: Icons.star,
                    color: Colors.amber,
                    unlocked: completedLevels >= 1,
                  ),
                  _Trophy(
                    title: 'Level Master',
                    description: 'Complete 5 levels',
                    icon: Icons.workspace_premium,
                    color: Colors.blue,
                    unlocked: completedLevels >= 5,
                  ),
                  _Trophy(
                    title: 'Expert Learner',
                    description: 'Complete 10 levels',
                    icon: Icons.emoji_events,
                    color: Colors.purple,
                    unlocked: completedLevels >= 10,
                  ),
                  _Trophy(
                    title: 'Point Collector',
                    description: 'Earn 100 points',
                    icon: Icons.stars,
                    color: Colors.orange,
                    unlocked: totalPoints >= 100,
                  ),
                  _Trophy(
                    title: 'High Achiever',
                    description: 'Earn 500 points',
                    icon: Icons.workspace_premium,
                    color: Colors.indigo,
                    unlocked: totalPoints >= 500,
                  ),
                  _Trophy(
                    title: 'Point Master',
                    description: 'Earn 1000 points',
                    icon: Icons.emoji_events,
                    color: Colors.amber.shade700,
                    unlocked: totalPoints >= 1000,
                  ),
                  _Trophy(
                    title: 'On Fire',
                    description: 'Maintain a 3-day streak',
                    icon: Icons.local_fire_department,
                    color: Colors.deepOrange,
                    unlocked: streak >= 3,
                  ),
                  _Trophy(
                    title: 'Consistent',
                    description: 'Maintain a 7-day streak',
                    icon: Icons.whatshot,
                    color: Colors.red,
                    unlocked: streak >= 7,
                  ),
                  _Trophy(
                    title: 'Dedicated',
                    description: 'Maintain a 30-day streak',
                    icon: Icons.local_fire_department,
                    color: Colors.deepOrange.shade700,
                    unlocked: streak >= 30,
                  ),
                  _Trophy(
                    title: 'Translator',
                    description: 'Translate 10 texts',
                    icon: Icons.translate,
                    color: Theme.of(context).colorScheme.primary,
                    unlocked: translationCount >= 10,
                  ),
                  _Trophy(
                    title: 'Language Expert',
                    description: 'Translate 50 texts',
                    icon: Icons.language,
                    color: Theme.of(context).colorScheme.secondary,
                    unlocked: translationCount >= 50,
                  ),
                ];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          Text(
                            'Trophies',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your Achievements',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${trophies.where((t) => t.unlocked).length} of ${trophies.length} unlocked',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                      ),
                      const SizedBox(height: 24),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: trophies.length,
                        itemBuilder: (context, index) {
                          final trophy = trophies[index];
                          return _TrophyCard(trophy: trophy);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Trophy {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool unlocked;

  _Trophy({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.unlocked,
  });
}

class _TrophyCard extends StatelessWidget {
  final _Trophy trophy;

  const _TrophyCard({required this.trophy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: trophy.unlocked
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: trophy.unlocked
              ? trophy.color.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          width: trophy.unlocked ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            trophy.icon,
            size: 48,
            color: trophy.unlocked
                ? trophy.color
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            trophy.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: trophy.unlocked
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            trophy.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: trophy.unlocked
                      ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}