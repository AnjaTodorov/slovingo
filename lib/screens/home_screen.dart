import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/widgets/word_of_the_day_card.dart';
import 'package:slovingo/widgets/level_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${provider.currentUser?.name ?? "Learner"}!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Continue learning Slovenian',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                  const SizedBox(height: 24),
                  if (provider.wordOfDay != null) WordOfDayCard(word: provider.wordOfDay!),
                  const SizedBox(height: 32),
                  Text(
                    'Starter',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber == 1)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                  Text(
                    'Beginner',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber >= 2 && level.levelNumber <= 5)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                  Text(
                    'Intermediate',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber >= 6 && level.levelNumber <= 9)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                  Text(
                    'Upper Intermediate',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber >= 10 && level.levelNumber <= 13)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                  Text(
                    'Advanced',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber >= 14 && level.levelNumber <= 17)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                  Text(
                    'Expert',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels
                      .where((level) => level.levelNumber >= 18)
                      .map((level) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LevelCard(level: level),
                          )),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
