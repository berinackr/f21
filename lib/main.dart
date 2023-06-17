import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:f21_demo/router.dart';
import 'package:f21_demo/core/common/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final isFirstTime = ref.watch(isFirstTimeProvider);
    return isFirstTime
        ? const Splash()
        : MaterialApp.router(
            title: 'Flutter f21 Demo 3',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: router);
  }
}
