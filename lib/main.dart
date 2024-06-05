import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/widgets/custom_scaffold.dart';
import 'src/features/auth/views/signin_view.dart';
import 'src/features/auth/views/signup_view.dart';
import 'src/features/auth/widget/auth_protected_shell.dart';
import 'src/features/home/views/home_view.dart';

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
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const SigninView(),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupView(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AuthProtectedShell(child),
      routes: [
        GoRoute(
          path: '/',
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
  ],
);
