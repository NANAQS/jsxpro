import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsxpro/components/input_custom.dart';
import 'package:jsxpro/controller/login_controller.dart';

import '../components/button_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.of(context).popAndPushNamed("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = LoginController(formKey, context);
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(150),
              ),
              width: 250,
              height: 250,
            ),
          ),
          Positioned(
            bottom: -20,
            right: -20,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(150),
              ),
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(150),
              ),
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            top: 210,
            right: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(150),
              ),
              width: 30,
              height: 30,
            ),
          ),
          Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "JSXPro",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                  ),
                  InputCustom(
                    validador: controller.userValidador,
                    text: "Email",
                    password: false,
                    inputController: email,
                  ),
                  InputCustom(
                    validador: controller.passwordValidador,
                    text: "Senha",
                    password: true,
                    inputController: password,
                  ),
                  ButtonCustom(
                    onPressed: () async =>
                        await controller.loginClick(email.text, password.text),
                    text: "Fazer Login",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
