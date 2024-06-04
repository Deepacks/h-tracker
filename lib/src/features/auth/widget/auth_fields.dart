import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:h_tracker/src/features/auth/providers/auth_form_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/custom_elevated_button.dart';

class AuthFields extends HookConsumerWidget {
  final String title;
  final String label;
  final void Function(String email, String password) onSubmit;
  final bool loading;

  const AuthFields({
    super.key,
    required this.title,
    required this.label,
    required this.onSubmit,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(authFormStateNotifierProvider, (prev, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: () {
          context.go('/home');
        },
        unauthenticated: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(height: 30),
        Center(
          child: CustomElevatedButton(
            disabled: loading,
            onPressed: () => onSubmit(
              emailController.text,
              passwordController.text,
            ),
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
