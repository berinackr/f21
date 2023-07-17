import 'package:f21_demo/core/assets.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

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

  void signInWithGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final isLoading = ref.watch(authControllerProvider);
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          if (isLoading) return const Loader();
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: CustomStyles.backgroundColor,
                image: const DecorationImage(
                  image: AssetImage('assets/images/backgroundimg.png'),
                  fit: BoxFit.cover,
                ),
              ),
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
                        backgroundImage: const AssetImage(Assets.logoPath),
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
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: CustomStyles.forumTextColor,
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
                                decoration: InputDecoration(
                                  hintText: "johndoe@gmail.com",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  filled: true,
                                  fillColor: CustomStyles.fillColor,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            //Password Label
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight / 60,
                                  left: screenHeight / 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Şifre",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomStyles.forumTextColor,
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
                                decoration: InputDecoration(
                                  hintText: "Passw0rd!",
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  fillColor: CustomStyles.fillColor,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Login Buttons
                      //Giriş Yap Butonu
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight / 30, 0, screenHeight / 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomStyles.buttonColor),
                              onPressed: () {
                                context.push("/guest/home");
                              },
                              child: Text(
                                "Misafir olarak devam et",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomStyles.buttonColor),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signIn(ref, emailController.text,
                                        passwordController.text, context);
                                    passwordController.clear();
                                  }
                                },
                                child: Text(
                                  "Giriş Yap",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Google ile Giriş Yap Butonu
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomStyles.buttonColor),
                          onPressed: () {
                            signInWithGoogle(ref, context);
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
                                    child: Image.asset(Assets.googleIconPath),
                                  ),
                                  Text(
                                    "Google ile Giriş Yap",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade700),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.push("/auth/forget");
                                  },
                                  child: Text(
                                    "Şifremi Unuttum",
                                    style: TextStyle(
                                        color: CustomStyles.forumTextColor,
                                        fontSize: 17),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      context.push("/auth/register");
                                    },
                                    child: Text(
                                      "Kayıt Ol",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: CustomStyles.forumTextColor,
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
    );
  }
}
