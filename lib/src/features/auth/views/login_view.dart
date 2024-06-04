import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'signup_view.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../widget/auth_fields.dart';
import '../providers/auth_form_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Login',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthFields(
            title: 'Welcome, Log back in',
            label: 'Sign in',
            loading: ref
                .watch(authFormStateNotifierProvider)
                .maybeWhen(orElse: () => false, loading: () => true),
            onSubmit: (email, password) => ref
                .read(authFormStateNotifierProvider.notifier)
                .login(email: email, password: password),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account? '),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupView(),
                  ),
                ),
                child: const Text('Signup'),
              ),
            ],
          ),
          // const SizedBox(height: 30),
          // Center(
          //   child: SignInButton(Buttons.GoogleDark, onPressed: () {}),
          // ),
        ],
      ),
    );
  }
}
