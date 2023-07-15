import 'package:f21_demo/core/common/loading_screen.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/password_reset_info_screen.dart';
import 'package:f21_demo/features/forum/screens/bookmarked_posts_screen.dart';
import 'package:f21_demo/features/forum/screens/forum_feed_screen.dart';
import 'package:f21_demo/features/forum/screens/forum_screen.dart';
import 'package:f21_demo/features/forum/screens/post_screen.dart';
import 'package:f21_demo/features/forum/screens/share_post_screen.dart';
import 'package:f21_demo/features/home/screens/activity_screen.dart';
import 'package:f21_demo/features/home/screens/guest_home_screen.dart';
import 'package:f21_demo/features/home/screens/home_screen.dart';
import 'package:f21_demo/features/auth/screens/forgot_password_screen.dart';
import 'package:f21_demo/features/auth/screens/login_screen.dart';
import 'package:f21_demo/features/auth/screens/register_screen.dart';
import 'package:f21_demo/features/profile/screens/change_password_screen.dart';
import 'package:f21_demo/features/profile/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/settings/screens/settings_screen.dart';

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
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen(), routes: [
        GoRoute(
          path: ':activity_type/:activity_id',
          builder: (context, state) => ActivityScreen(activityId: state.pathParameters["activity_id"], activityType: state.pathParameters["activity_type"],),
        ),
      ]),
      GoRoute(
        path: '/home/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/home/profile/change_pass',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/home/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: "/home/bookmarks", builder: (context, state) => const BookmarkedPostsScreen()),
      GoRoute(path: "/auth", builder: (context, state) => const LoginScreen()),
      GoRoute(path: "/auth/register", builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: "/auth/forget",
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: "/auth/forget/reset", builder: (context, state) => const PasswordResetInfoScreen()),
      GoRoute(path: "/forum", builder: (context, state) => const ForumScreen(), routes: [
        GoRoute(
          path: ":categoryId",
          builder: (context, state) => ForumFeedScreen(id: state.pathParameters["categoryId"]!),
          routes: [
            GoRoute(
              path: "share",
              builder: (context, state) => SharePostScreen(id: state.pathParameters['categoryId']!),
            )
          ],
        ),
        GoRoute(path: "post/:postId", builder: (context, state) => PostScreen(id: state.pathParameters["postId"]!))
      ]),
      GoRoute(path: "/guest", builder: (context, state) => const GuestHomeScreen(), routes: [
        GoRoute(
          path: "home",
          builder: (context, state) => const GuestHomeScreen(),
        ),
      ])
    ],
    redirect: (context, state) {
      if (authState.isLoading || authState.hasError || authState.isRefreshing || authState.isReloading) return null;
      final isAuth = authState.valueOrNull != null;
      final isSplash = state.location == "/";
      final isForum = state.matchedLocation.startsWith("/forum");
      if (isForum) return null;
      if (isSplash) {
        if (isAuth && userModel == null) {
          getData(authState.value!.uid);
        }
        return isAuth ? "/home" : "/auth";
      }
      final isLoggingIn = state.matchedLocation.startsWith("/auth");
      final isGuest = state.matchedLocation.startsWith("/guest");
      if (isLoggingIn || isGuest) return isAuth ? "/home" : null;
      return isAuth ? null : "/";
    },
  );
});
