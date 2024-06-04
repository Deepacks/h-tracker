import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../user/providers/user_provider.dart';
import '../../../core/widgets/custom_scaffold.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Main view',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => context.go('/home/route'),
            child: const Text('Go to next route'),
          ),
          TextButton(
            onPressed: () =>
                ref.read(userStateNotifierProvider.notifier).logout(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
