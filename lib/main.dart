import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jsxpro/routes/main.dart';
import 'package:jsxpro/theme/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: themeLight,
      darkTheme: themeDark,
      routes: routes,
    );
  }
}
