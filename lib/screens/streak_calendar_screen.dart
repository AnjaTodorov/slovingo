import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class StreakCalendarScreen extends StatefulWidget {
  const StreakCalendarScreen({super.key});

  @override
  State<StreakCalendarScreen> createState() => _StreakCalendarScreenState();
}

class _StreakCalendarScreenState extends State<StreakCalendarScreen> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    // Set to first day of the month
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _shareStreak(int streakCount) {
    final message = '🔥 I have a $streakCount-day streak learning Slovenian on Slovingo! Join me in learning this beautiful language! 📚✨';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak Calendar'),
      ),
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final user = provider.currentUser;
            if (user == null) {
              return const Center(child: Text('Please log in to view your streak'));
            }

            final streakDays = user.streakDays.toSet();
            final streakCount = user.streak;
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            
            // Get first day of the month and how many days in the month
            final firstDay = _currentMonth;
            final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
            final daysInMonth = lastDay.day;
            
            // Get the weekday of the first day (1 = Monday, 7 = Sunday)
            // Adjust to make Monday = 0, Sunday = 6
            int firstDayWeekday = firstDay.weekday - 1;
            
            // Generate all days in the month
            final days = <DateTime>[];
            for (int i = 1; i <= daysInMonth; i++) {
              days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Streak stats
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 48,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$streakCount Day Streak',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                              ),
                              Text(
                                'Keep it up!',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () => _shareStreak(streakCount),
                          tooltip: 'Share streak',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Month navigation header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _previousMonth,
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(_currentMonth),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _nextMonth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Weekday headers
                  Row(
                    children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  // Calendar grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: firstDayWeekday + daysInMonth,
                    itemBuilder: (context, index) {
                      if (index < firstDayWeekday) {
                        // Empty cells before first day
                        return const SizedBox();
                      }
                      
                      final dayIndex = index - firstDayWeekday;
                      final day = days[dayIndex];
                      final dayStr = _formatDate(day);
                      final hasStreak = streakDays.contains(dayStr);
                      final isToday = dayStr == _formatDate(today);
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: isToday && !hasStreak
                              ? Theme.of(context).colorScheme.surfaceContainerHighest
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isToday && !hasStreak
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Day number
                            Text(
                              '${day.day}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: hasStreak
                                        ? Colors.deepOrange
                                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                  ),
                            ),
                            // Fire icon overlay
                            if (hasStreak)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Icon(
                                  Icons.local_fire_department,
                                  size: 16,
                                  color: Colors.deepOrange,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 20,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Active day',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
