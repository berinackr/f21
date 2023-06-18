import 'package:f21_demo/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordResetInfoScreen extends StatefulWidget {
  const PasswordResetInfoScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetInfoScreen> createState() => _PasswordResetInfoScreenState();
}

class _PasswordResetInfoScreenState extends State<PasswordResetInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 174, 209),
        //toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 155, 174, 209),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 155, 174, 209),
                constraints: BoxConstraints(
                  minWidth: viewportConstraints.maxWidth,
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      //Logo
                      CircleAvatar(
                        radius: screenWidth / 4,
                        backgroundImage: const AssetImage(Assets.logoPath),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      //Şifremi Sıfırla Label
                      const Text(
                        "ŞİFRENİZ SIFIRLANDI!",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 31, 4, 99),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 249, 191, 178),
                        size: 160,
                      ),
                      const Spacer(flex: 1),
                      //Info Label
                      const Text(
                        "Lütfen posta kutunuzu kontrol ediniz. Eğer bu mail adresi sistemimize kayıtlı ise yeni şifreniz mail adresinize gönderilecektir.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 31, 4, 99),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
