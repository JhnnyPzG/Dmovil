import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Image.asset('assets/paisaje.jpg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Barrancabermeja',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Colombia',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.red[500],
                      ),
                      Text('100'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
                _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
                _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Barrancabermeja, es un distrito colombiano ubicado a orillas del río Magdalena, en la parte occidental del departamento de Santander. Es la ciudad industrial más importante del departamento de Santander, sede de la refinería de petróleo más grande del país y es la capital de la Provincia de Yariguíes.6​ Dista 114 km de Bucaramanga hacia el occidente. Es la ciudad más grande en la subregión natural del denominado Magdalena Medio; sede de la Policía del Magdalena Medio, de la Corporación Autónoma del Río Grande de la Magdalena, de la Diócesis de Barrancabermeja.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
