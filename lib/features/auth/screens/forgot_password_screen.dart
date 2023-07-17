import 'package:f21_demo/core/assets.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  void resetPassword(WidgetRef ref, String email, BuildContext context) {
    ref.read(authControllerProvider.notifier).resetPassword(email, context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isLoading = ref.watch(authControllerProvider);
    CustomStyles().responsiveTheme(isDarkMode);
    var screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CustomStyles.primaryColor),
        backgroundColor: Colors.transparent,
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
                  fit: BoxFit.none,
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
                    Text(
                      "ŞİFREMİ SIFIRLA",
                      style: TextStyle(
                        fontSize: 20,
                        color: CustomStyles.forumTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Info Label
                    Text(
                      "Lütfen sisteme kayıtlı olan email adresinizi giriniz.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: CustomStyles.forumTextColor,
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
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          autofillHints: const [AutofillHints.email],
                          validator: ValidationBuilder(localeName: "tr")
                              .email()
                              .build(),
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "johndoe@gmail.com",
                            filled: true,
                            fillColor: CustomStyles.fillColor,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
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
                          if (_formKey.currentState!.validate()) {
                            resetPassword(ref, emailController.text, context);
                          }
                        },
                        child: Text(
                          "Mail Gönder",
                          style: TextStyle(color: Colors.grey.shade700),
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
    );
  }
}
