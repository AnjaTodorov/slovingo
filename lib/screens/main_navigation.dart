import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/screens/home_screen.dart';
import 'package:slovingo/screens/translate_screen.dart';
import 'package:slovingo/screens/chat_screen.dart';
import 'package:slovingo/screens/statistics_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;
  
  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const TranslateScreen(),
      const ChatScreen(),
      const StatisticsScreen(),
    ];
    // Kick off data loading once the widget is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.translate, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.translate, color: Theme.of(context).colorScheme.primary),
              label: 'Translate',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.chat_bubble, color: Theme.of(context).colorScheme.primary),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
              label: 'Statistics',
            ),
          ],
        ),
      ),
    );
  }
}