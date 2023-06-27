import 'package:f21_demo/core/providers/settings_repository.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:f21_demo/router.dart';
import 'package:f21_demo/core/common/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';
import 'package:f21_demo/core/custom_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final router = ref.watch(routerProvider);
    final isFirstTime = ref.watch(isFirstTimeProvider);
    return isFirstTime
        ? const Splash()
        : MaterialApp.router(
            title: 'Flutter f21 Demo 3',
            debugShowCheckedModeBanner: false,
            themeMode: ref.watch(settingsProvider).isDarkMode()
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 31, 4, 99),
                secondary: Color.fromARGB(255, 155, 174, 209),
              ),
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: Color.fromARGB(255, 236, 236, 236),
                headerBackgroundColor: Color.fromARGB(255, 31, 4, 99),
                headerForegroundColor: Color.fromARGB(255, 236, 236, 236),
              ),
            ),
            routerConfig: router);
  }
}
