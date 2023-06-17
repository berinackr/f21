import 'package:f21_demo/core/common/loading_screen.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/password_reset_info_screen.dart';
import 'package:f21_demo/features/home/screens/home_screen.dart';
import 'package:f21_demo/features/auth/screens/forgot_password_screen.dart';
import 'package:f21_demo/features/auth/screens/login_screen.dart';
import 'package:f21_demo/features/auth/screens/register_screen.dart';
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
      GoRoute(path: "/", builder: (context, state) => const LoadingScreen()),
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
      GoRoute(path: "/auth", builder: (context, state) => const LoginScreen()),
      GoRoute(path: "/auth/register", builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: "/auth/forget",
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: "/auth/forget/reset", builder: (context, state) => const PasswordResetInfoScreen())
    ],
    redirect: (context, state) {
      if (authState.isLoading || authState.hasError || authState.isRefreshing || authState.isReloading) return null;
      final isAuth = authState.valueOrNull != null;
      final isSplash = state.location == "/";
      if (isSplash) {
        if (isAuth && userModel == null) {
          getData(authState.value!.uid);
        }
        return isAuth ? "/home" : "/auth";
      }
      final isLoggingIn = state.matchedLocation.startsWith("/auth");
      if (isLoggingIn) return isAuth ? "/home" : null;
      return isAuth ? null : "/";
    },
  );
});
