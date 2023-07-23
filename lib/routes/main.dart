import 'package:flutter/material.dart';

import '../view/home_screen.dart';
import '../view/login_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/home": (p0) => const HomeScreen(),
  "/": (p0) => const LoginScreen(),
};
