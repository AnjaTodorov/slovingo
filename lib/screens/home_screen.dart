import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/widgets/word_of_the_day_card.dart';
import 'package:slovingo/widgets/level_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

            return Column(
              children: [
                // Compact Navbar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Profile Icon
                      _ProfileNavIcon(
                        profileImageUrl: provider.currentUser?.profileImageUrl,
                        onTap: () => context.push('/profile'),
                      ),
                      // Streak Icon with label next to it
                      _StreakNavIcon(
                        streak: provider.currentUser?.streak ?? 0,
                        onTap: () => context.push('/streak-calendar'),
                      ),
                      // Trophies Icon
                      _NavBarIconNoLabel(
                        icon: Icons.emoji_events_outlined,
                        selectedIcon: Icons.emoji_events,
                        color: Theme.of(context).colorScheme.tertiary,
                        onTap: () => context.push('/trophies'),
                      ),
                      // Search Icon
                      _NavBarIconNoLabel(
                        icon: Icons.search_outlined,
                        selectedIcon: Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                        onTap: () => context.push('/search-lessons'),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (provider.wordOfDay != null) WordOfDayCard(word: provider.wordOfDay!),
                        if (provider.wordOfDay != null) const SizedBox(height: 24),
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
                  ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarIconNoLabel extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final VoidCallback onTap;
  final Color? color;

  const _NavBarIconNoLabel({
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).colorScheme.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}

class _StreakNavIcon extends StatelessWidget {
  final int streak;
  final VoidCallback onTap;

  const _StreakNavIcon({
    required this.streak,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department,
              color: Colors.deepOrange,
              size: 28,
            ),
            const SizedBox(width: 6),
            Text(
              '$streak',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileNavIcon extends StatelessWidget {
  final String? profileImageUrl;
  final VoidCallback onTap;

  const _ProfileNavIcon({
    required this.profileImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: profileImageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      'assets/character.png',
                      fit: BoxFit.cover,
                      width: 28,
                      height: 28,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/character.png',
                      fit: BoxFit.cover,
                      width: 28,
                      height: 28,
                    ),
                  )
                : Image.asset(
                    'assets/character.png',
                    fit: BoxFit.cover,
                    width: 28,
                    height: 28,
                  ),
          ),
        ),
      ),
    );
  }
}
