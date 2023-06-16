import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value){
      Navigator.of(context).pushNamedAndRemoveUntil("/loginScreen", (route) => false);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 155,174,209),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(builder: (BuildContext context,BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: const Color.fromARGB(255, 155,174,209),
              constraints: BoxConstraints(
                minWidth: viewportConstraints.maxWidth,
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: viewportConstraints.maxWidth/4,
                      backgroundImage: const AssetImage("assets/images/logo.png"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("BİBERON",
                        style: TextStyle(
                          color: Color.fromARGB(255, 31, 4, 99),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text("' Başucunuzdaki anne desteği '",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 31, 4, 99),
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}

