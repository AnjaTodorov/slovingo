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
                    'Živjo, ${provider.currentUser?.name ?? "Učenec"}! 👋',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nadaljujte z učenjem slovenščine',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (provider.wordOfDay != null) WordOfDayCard(word: provider.wordOfDay!),
                  const SizedBox(height: 32),
                  Text(
                    'Učni nivoji',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...provider.levels.map((level) => Padding(
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