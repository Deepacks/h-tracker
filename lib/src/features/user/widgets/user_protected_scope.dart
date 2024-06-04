import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h_tracker/src/core/widgets/custom_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/user_provider.dart';

class UserProtectedScope extends ConsumerWidget {
  final Widget child;

  const UserProtectedScope(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateNotifierProvider);

    return userState.maybeWhen(
      orElse: () => CustomScaffold.empty(),
      authenticated: () => child,
      unauthenticated: () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => context.go('/login'),
        );
        return CustomScaffold.empty();
      },
    );
  }
}
