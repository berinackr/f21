import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/custom_styles.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  late AuthRepository authProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _passwordControllerOld = TextEditingController();

  //For Show/Hide Password Button
  bool isShowPassword = true;

  void _toggleShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  //isLoading
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.read(authRepositoryProvider).getCurrentUser()!;
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Şifreni Değiştir"),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: viewportConstraints.maxHeight,
                      maxWidth: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                validator: ValidationBuilder(localeName: 'tr')
                                    .required()
                                    .minLength(6)
                                    .checkOldPassword(_passwordControllerOld,
                                        _passwordController2)
                                    .build(),
                                name: "password_old",
                                obscureText: isShowPassword,
                                controller: _passwordControllerOld,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _toggleShowPassword();
                                    },
                                    icon: isShowPassword
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                  label: const Text("Eski Şifreniz"),
                                  hintText: "Eski şifrenizi girin.",
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  fillColor: CustomStyles.fillColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FormBuilderTextField(
                                validator: ValidationBuilder(localeName: 'tr')
                                    .required()
                                    .minLength(6)
                                    .repeatPassword(_passwordController1,
                                        _passwordController2)
                                    .build(),
                                name: "password_1",
                                obscureText: isShowPassword,
                                controller: _passwordController1,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _toggleShowPassword();
                                    },
                                    icon: isShowPassword
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                  label: const Text("Yeni Şifreniz"),
                                  hintText: "Yeni şifrenizi girin.",
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  fillColor: CustomStyles.fillColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FormBuilderTextField(
                                validator: ValidationBuilder(localeName: 'tr')
                                    .required()
                                    .minLength(6)
                                    .repeatPassword(_passwordController1,
                                        _passwordController2)
                                    .build(),
                                name: "password_2",
                                obscureText: isShowPassword,
                                controller: _passwordController2,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _toggleShowPassword();
                                    },
                                    icon: isShowPassword
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                  label: const Text("Şifre Tekrar"),
                                  hintText: "Yeni şifrenizi tekrar girin",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  fillColor: CustomStyles.fillColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    var newPassword = _passwordController2.text;
                                    var oldPassword =
                                        _passwordControllerOld.text;

                                    final credential =
                                        EmailAuthProvider.credential(
                                            email: user.email!,
                                            password: oldPassword);

                                    await user
                                        .reauthenticateWithCredential(
                                            credential)
                                        .then((value) async {
                                      await user
                                          .updatePassword(newPassword)
                                          .then((_) {
                                        //Değiştirme işlemi başarılı
                                        showSnackBar(context,
                                            "Şifre başarıyla değiştirildi.");
                                        context.pop();
                                      }).catchError((error) {
                                        showSnackBar(
                                            context,
                                            findAuthExceptionErrorMessage(
                                                error)!);
                                      });
                                    }).catchError((error) {
                                      showSnackBar(
                                          context,
                                          findAuthExceptionErrorMessage(
                                              error)!);
                                    }).then(
                                      (value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                    );
                                  }
                                },
                                child: const Text("Şifremi Değiştir"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
