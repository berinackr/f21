import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class ExampleSignUp extends ConsumerStatefulWidget {
  const ExampleSignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExampleSignUpState();
}

class _ExampleSignUpState extends ConsumerState<ExampleSignUp> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUp(WidgetRef ref, String email, String password, BuildContext context) {
    ref.read(authControllerProvider.notifier).signUp(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: isLoading
          ? const Loader()
          : Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: ValidationBuilder(localeName: "tr").email().build(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      controller: emailController,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      validator: ValidationBuilder(localeName: "tr").minLength(6).build(),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      autofillHints: const [AutofillHints.password],
                      autocorrect: false,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        if (_formKey.currentState!.validate())
                          {
                            signUp(ref, emailController.text, passwordController.text, context),
                            emailController.clear(),
                            passwordController.clear(),
                          },
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
