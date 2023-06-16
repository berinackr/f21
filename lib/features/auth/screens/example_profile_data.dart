import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleProfileData extends ConsumerWidget {
  const ExampleProfileData({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void setProfileInfos(WidgetRef ref, BuildContext context) {
    ref
        .read(authControllerProvider.notifier)
        .setProfileInfos("deneme", DateTime.now(), "kız", true, "", 3, null, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => logOut(ref),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => setProfileInfos(ref, context),
          child: const Text("Gönder"),
        ),
      ),
    );
  }
}
