import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

//FORM VALIDATOR EKLENECEK
//BUTONLAR BÜYÜYECEK
//EN ALTTAKİ TEXTLERE CLİCKABLE ÖZELLİĞİ EKLENECEK
//LOGO RESİM YUVARLAKLAŞTIRILACAK
//KULLANICIDAN GERÇEKTEN BİLGİ ALACAĞIZ

//----------
//FİREBASE İLE BAĞLAYACAĞIZ

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signIn(
      WidgetRef ref, String email, String password, BuildContext context) {
    ref.read(authControllerProvider.notifier).signIn(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 155, 174, 209),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            if (isLoading) return const Loader();
            return SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 155, 174, 209),
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        //Logo
                        CircleAvatar(
                          radius: screenWidth / 4,
                          backgroundImage:
                              const AssetImage("assets/images/logo.png"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Email Label
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight / 60,
                                    left: screenHeight / 30),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 31, 4, 99),
                                      ),
                                    )),
                              ),
                              //Email TextField
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    screenHeight / 30,
                                    screenHeight / 100,
                                    screenHeight / 30,
                                    screenHeight / 30),
                                child: TextFormField(
                                  validator: ValidationBuilder(localeName: "tr")
                                      .email()
                                      .build(),
                                  controller: emailController,
                                  autofillHints: const [AutofillHints.email],
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: "johndoe@gmail.com",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 236, 236, 236),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              ),
                              //Password Label
                              Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight / 60,
                                    left: screenHeight / 30),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Şifre",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 31, 4, 99),
                                    ),
                                  ),
                                ),
                              ),
                              //Password TextField
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    screenHeight / 30,
                                    screenHeight / 100,
                                    screenHeight / 30,
                                    screenHeight / 30),
                                child: TextFormField(
                                  validator: ValidationBuilder(localeName: "tr")
                                      .minLength(6)
                                      .build(),
                                  obscureText: true,
                                  controller: passwordController,
                                  autofillHints: const [AutofillHints.password],
                                  autocorrect: false,
                                  decoration: const InputDecoration(
                                    hintText: "Passw0rd!",
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    fillColor:
                                        Color.fromARGB(255, 236, 236, 236),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //DENEME ŞİFRE TASARIMI SONRA DEFAULT OLANLAR YERİNE GEÇİRİLEBİLİR
                        /*Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: Colors.transparent,
                            child: TextFormField(
                              cursorColor: const Color.fromARGB(255, 31, 4, 99),
                              initialValue: '',
                              //maxLength: 20, //şifrede karakter sınırı yok
                              decoration: const InputDecoration(
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                icon: Icon(Icons.password_outlined),
                                hintText: "Şifrenizi tekrar girin",
                                labelText: 'Şifre Tekrar',
                                labelStyle: TextStyle(
                                  color: Color(0xFF6200EE),
                                ),
                                //helperText: 'Güçlü bir şifre için en az 8 karakter kullanın',
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 5,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 31, 4, 99),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        */

                        //Login Buttons
                        //Giriş Yap Butonu
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 249, 191, 178)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signIn(ref, emailController.text,
                                    passwordController.text, context);
                                passwordController.clear();
                              }
                            },
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 31, 4, 99)),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        //Google ile Giriş Yap Butonu
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 249, 191, 178)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Google ile giriş yap'a tıklandi")));
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/images/google_icon.png"),
                                    ),
                                    const Text(
                                      "Google ile Giriş Yap",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 31, 4, 99)),
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight / 25),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.push("/auth/forget");
                                    },
                                    child: const Text(
                                      "Şifremi Unuttum",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 31, 4, 99),
                                          fontSize: 17),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context.push("/auth/register");
                                      },
                                      child: const Text(
                                        "Kayıt Ol",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 31, 4, 99),
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
