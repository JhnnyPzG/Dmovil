import 'package:flutter/material.dart';
import 'views/buttonview.dart';
import 'views/titleview.dart';
import 'views/imageview.dart';
import 'views/textview.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            CustomImage(), // Usando el módulo de la imagen
            CustomTitle(), // Usando el módulo del título
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  color: Colors.blue,
                  icon: Icons.call,
                  label: 'CALL',
                ),
                CustomButton(
                  color: Colors.blue,
                  icon: Icons.near_me,
                  label: 'ROUTE',
                ),
                CustomButton(
                  color: Colors.blue,
                  icon: Icons.share,
                  label: 'SHARE',
                ),
              ],
            ),
            CustomText(), // Usando el módulo del texto
          ],
        ),
      ),
    );
  }
}
