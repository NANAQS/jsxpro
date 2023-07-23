import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginController {
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  LoginController(this.formKey, this.context);

  userValidador(String text) {
    if (text.isEmpty) {
      return "Por favor preencha o usuario";
    }

    return null;
  }

  passwordValidador(String text) {
    if (text.isEmpty) {
      return "Por favor preencha a senha";
    } else if (text.length <= 8) {
      return "Senha invalida";
    }

    return null;
  }

  Future<void> loginClick(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        final UserCredential response = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // ignore: unnecessary_null_comparison
        if (response != null) {
          final user = response.user;
          final database =
              FirebaseDatabase.instance.ref("usuarios/${user?.uid}");
          if (user != null) {
            await database.set({
              "name": user.displayName,
              "email": user.email,
              "photo": user.photoURL
            });
          }
          Navigator.popAndPushNamed(context, "/home");
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Text("${e.message}"),
          ),
        );
      }
    }
  }
}
