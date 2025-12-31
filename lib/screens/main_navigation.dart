import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/screens/home_screen.dart';
import 'package:slovingo/screens/translate_screen.dart';
import 'package:slovingo/screens/chat_screen.dart';
import 'package:slovingo/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TranslateScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
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
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
              label: 'Domov',
            ),
            NavigationDestination(
              icon: Icon(Icons.translate, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.translate, color: Theme.of(context).colorScheme.primary),
              label: 'Prevod',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.chat_bubble, color: Theme.of(context).colorScheme.primary),
              label: 'Klepet',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              selectedIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
