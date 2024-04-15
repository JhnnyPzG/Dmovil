import 'package:actividad_7/views/pages/HomePage.dart';
import 'package:actividad_7/views/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
