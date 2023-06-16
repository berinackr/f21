import 'package:f21_demo/core/common/loading_screen.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/example_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user == null
        ? const LoadingScreen()
        : user.birthDate == null
            ? const ExampleProfileData()
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () => logOut(ref),
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                body: Center(
                  child: Text(user.username ?? 'No user'),
                ));
  }
}
