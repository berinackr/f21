import 'package:f21_demo/core/assets.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final isLoading = ref.watch(authControllerProvider);
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    bool isChecked = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CustomStyles.primaryColor),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
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
                          const SizedBox(
                            height: 5,
                          ),

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
                              decoration: InputDecoration(
                                hintText: "johndoe@gmail.com",
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
                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: screenHeight / 30),
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
                          const SizedBox(
                            height: 5,
                          ),

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
                              decoration: InputDecoration(
                                hintText: "Şifre",
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
                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: screenHeight / 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Şifreyi Onayla",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomStyles.forumTextColor,
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
                              decoration: InputDecoration(
                                hintText: "Şifre Tekrar",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ads_click,
                                color: CustomStyles.forumTextColor,
                              ),
                              TextButton(
                                  onPressed: () {


                                    showContractPopup(context);
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


                    const SizedBox(
                      height: 10,
                    ),
                    /*const Spacer(
                      flex: 1,
                    ),*/


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
                        child: Text(
                          "Kayıt ol",
                          style: TextStyle(color: Colors.grey.shade700),
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
    );
  }
}

void showContractPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: CustomStyles.fillColor,



        title: const Center(
            child: Text('Kullanıcı Sözleşmesi ve Gizlilik Politikası')),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomStyles.titleColor,
            fontSize: 15),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        content: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/texts/user_policy.md'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: CustomStyles.buttonColor,
              ),
              child: Text(
                'Kapat',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
