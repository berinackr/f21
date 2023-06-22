import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Splash extends ConsumerWidget {
  const Splash({Key? key}) : super(key: key);

  _navigatetohome(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(milliseconds: 2500)).then((value) {
      if (context.mounted) {
        ref.watch(isFirstTimeProvider.notifier).trigger();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _navigatetohome(context, ref);
    return MaterialApp(
      title: 'Flutter f21 Demo 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: CustomStyles.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),

                  //logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const Text(
                    'BİBERON',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '"BAŞUCUNUZDAKİ ANNE DESTEĞİ"',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child:
                        Lottie.asset('assets/animations/splash-animation.json'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
