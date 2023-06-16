import 'package:f21_demo/core/common/splash_screen.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/example_signup.dart';
import 'package:f21_demo/features/home/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userModel = ref.watch(userProvider);

  void getData(String uid) async {
    final user = await ref.watch(authControllerProvider.notifier).getUserData(uid).first;
    ref.read(userProvider.notifier).update((state) => user);
  }

  return GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
      GoRoute(path: "/signup", builder: (context, state) => const ExampleSignUp()),
    ],
    redirect: (context, state) {
      if (authState.isLoading || authState.hasError) return null;
      final isAuth = authState.valueOrNull != null;
      final isSplash = state.location == "/";
      if (isSplash) {
        if (isAuth && userModel == null) {
          getData(authState.value!.uid);
        }
        return isAuth ? "/home" : "/signup";
      }
      final isLoggingIn = state.location == "/signup";
      if (isLoggingIn) return isAuth ? "/home" : null;
      return isAuth ? null : "/";
    },
  );
});
