import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/models/level.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/screens/level_detail_screen.dart';
import 'package:slovingo/screens/login_screen.dart';
import 'package:slovingo/screens/main_navigation.dart';
import 'package:slovingo/screens/quiz_screen.dart';
import 'package:slovingo/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router = GoRouter(
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loggingIn = state.matchedLocation == '/login';
      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginScreen()),
      ),
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
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Selector<AppProvider, ThemeMode>(
        selector: (_, app) => app.themeMode,
        builder: (context, themeMode, _) {
          return MaterialApp.router(
            title: 'Slovingo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

/// Helper to refresh GoRouter when auth state changes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}