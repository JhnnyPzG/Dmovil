import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        'Barrancabermeja, es un distrito colombiano ubicado a orillas del río Magdalena, en la parte occidental del departamento de Santander. Es la ciudad industrial más importante del departamento de Santander, sede de la refinería de petróleo más grande del país y es la capital de la Provincia de Yariguíes.6​ Dista 114 km de Bucaramanga hacia el occidente. Es la ciudad más grande en la subregión natural del denominado Magdalena Medio; sede de la Policía del Magdalena Medio, de la Corporación Autónoma del Río Grande de la Magdalena, de la Diócesis de Barrancabermeja.',
      ),
    );
  }
}
