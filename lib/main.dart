import 'package:f21_demo/models/user_model.dart';
import 'package:f21_demo/router.dart';
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
  bool isLoading = true;
  bool splashShowed = false;

  // void getData(WidgetRef ref, User data) async {
  //   userModel = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
  //   ref.read(userProvider.notifier).update((state) => userModel);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 4), () {
  //     setState(() {
  //       splashShowed = true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
        title: 'Flutter f21 Demo 3',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router
        // routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        //   if (data != null) {
        //     if (userModel != null) {
        //       return loggedInRoute;
        //     }
        //     if (isLoading) {
        //       Future.microtask(() => getData(ref, data));
        //     }
        //     return loadingRoute;
        //   }
        //   return loggedOutRoute;
        // }),
        // routeInformationParser: const RoutemasterParser(),
        );
  }



