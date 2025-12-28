import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/theme.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/screens/main_navigation.dart';
import 'package:slovingo/screens/level_detail_screen.dart';
import 'package:slovingo/screens/quiz_screen.dart';
import 'package:slovingo/models/level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
  create: (_) => AppProvider(),
  child: MaterialApp.router(
    title: 'Slovingo',
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
    routerConfig: GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainNavigation()),
        ),
        GoRoute(
          path: '/level/:id',
          pageBuilder: (context, state) {
            final level = state.extra as Level;
            return MaterialPage(
              child: LevelDetailScreen(level: level),
            );
          },
        ),
        GoRoute(
          path: '/quiz/:levelId',
          pageBuilder: (context, state) {
            final levelId = state.pathParameters['levelId']!;
            return MaterialPage(
              child: QuizScreen(levelId: levelId),
            );
          },
        ),
      ],
    ),
  ),
);

  }
}
