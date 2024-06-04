import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/widgets/custom_scaffold.dart';
import 'src/features/auth/views/login_view.dart';
import 'src/features/auth/views/signup_view.dart';
import 'src/features/home/views/home_view.dart';
import 'src/features/user/widgets/user_protected_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return UserProtectedScope(child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeView(),
          routes: [
            GoRoute(
              path: 'route',
              builder: (context, state) => const CustomScaffold(
                title: 'Main view',
                body: Text('hello'),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupView(),
    ),
  ],
);
