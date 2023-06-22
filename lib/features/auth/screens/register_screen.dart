import 'package:f21_demo/core/assets.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  void signUp(
      WidgetRef ref, String email, String password, BuildContext context) {
    ref.read(authControllerProvider.notifier).signUp(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    bool isChecked = false;

    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0,
        backgroundColor: CustomStyles.backgroundColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: CustomStyles.backgroundColor,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            if (isLoading) return const Loader();
            return SingleChildScrollView(
              child: Container(
                color: CustomStyles.backgroundColor,
                constraints: BoxConstraints(
                  minWidth: viewportConstraints.maxWidth,
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenHeight / 30),
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: CustomStyles.primaryColor,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            //Email TextField
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight / 30, 0, screenHeight / 30, 0),
                              child: TextFormField(
                                validator: ValidationBuilder(localeName: "tr")
                                    .email()
                                    .build(),
                                controller: emailController,
                                autofillHints: const [AutofillHints.email],
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "johndoe@gmail.com",
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
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
                            //Password Label
                            Padding(
                              padding: EdgeInsets.only(left: screenHeight / 30),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Şifre",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomStyles.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            //Password TextField
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight / 30, 0, screenHeight / 30, 0),
                              child: TextFormField(
                                validator: ValidationBuilder(localeName: "tr")
                                    .minLength(6)
                                    .build(),
                                obscureText: true,
                                controller: passwordController,
                                autofillHints: const [AutofillHints.password],
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  hintText: "Çok gizli şifre",
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
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
                            //Password Label
                            Padding(
                              padding: EdgeInsets.only(left: screenHeight / 30),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Şifreyi Onayla",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomStyles.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight / 30, 0, screenHeight / 30, 0),
                              child: TextFormField(
                                validator: ValidationBuilder(localeName: "tr")
                                    .minLength(6)
                                    .add((value) {
                                  return value != passwordController.text
                                      ? "şifreler uyuşmuyor"
                                      : null;
                                }).build(),
                                obscureText: true,
                                controller: passwordAgainController,
                                autofillHints: const [AutofillHints.password],
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  hintText: "Çok gizli şifre",
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  fillColor: CustomStyles.fillColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.ads_click,
                                  color: CustomStyles.primaryColor,
                                ),
                                TextButton(
                                    onPressed: () {
                                      //tiklayinca sozlesme ekranina gitmeli
                                      Navigator.of(context)
                                          .pushNamed("/sozlesmeEkrani");
                                    },
                                    child: const Text(
                                      "Sözleşmeyi Okudum, Onayladım.",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                      ),
                                    )),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Checkbox(
                                      checkColor: Colors.black,
                                      value: isChecked,
                                      onChanged: (checked) {
                                        setState(() {
                                          isChecked = checked!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Email Label

                      const SizedBox(
                        height: 10,
                      ),
                      /*const Spacer(
                        flex: 1,
                      ),*/

                      //Kayıt Ol Butonu
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomStyles.buttonColor),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (!isChecked) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  "Lütfen öncelikle sözleşmeyi onaylayın!",
                                  style: TextStyle(
                                      color: CustomStyles.errorColor,
                                      fontWeight: FontWeight.bold),
                                )));
                                return;
                              }
                              signUp(ref, emailController.text,
                                  passwordController.text, context);
                              passwordController.clear();
                              passwordAgainController.clear();
                            }
                          },
                          child: const Text(
                            "Kayıt ol",
                            style: TextStyle(color: CustomStyles.primaryColor),
                          )),
                      const Spacer(
                        flex: 1,
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
