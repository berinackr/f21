import 'package:f21_demo/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      body: SafeArea(
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
                child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_xD7kztjVaC.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
