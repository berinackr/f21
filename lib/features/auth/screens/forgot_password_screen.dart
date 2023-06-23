import 'package:f21_demo/core/assets.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        //toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: CustomStyles.backgroundColor,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: CustomStyles.backgroundColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundimg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                constraints: BoxConstraints(
                  minWidth: viewportConstraints.maxWidth,
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //Logo
                      CircleAvatar(
                        radius: screenWidth / 4,
                        backgroundImage: const AssetImage(Assets.logoPath),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Şifremi Sıfırla Label
                      const Text(
                        "ŞİFREMİ SIFIRLA",
                        style: TextStyle(
                          fontSize: 20,
                          color: CustomStyles.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Info Label
                      const Text(
                        "Lütfen sisteme kayıtlı olan email adresinizi giriniz.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomStyles.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Textfield Email
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.8,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "johndoe@gmail.com",
                            filled: true,
                            fillColor: CustomStyles.fillColor,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomStyles.buttonColor),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Mail gönderildi!")));
                            context.push("/auth/forget/reset");
                          },
                          child: const Text(
                            "Mail Gönder",
                            style: TextStyle(color: CustomStyles.primaryColor),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Spam kutusunu kontrol etmeyi unutmayınız.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomStyles.errorColor,
                          ),
                        ),
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
