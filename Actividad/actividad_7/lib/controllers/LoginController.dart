import 'package:flutter/material.dart';

class SignUpService {
  static void signup(BuildContext context, String email, String password) {
    print("$email $password");
    Navigator.pushNamed(context, "home");
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }
    return null;
  }
}
