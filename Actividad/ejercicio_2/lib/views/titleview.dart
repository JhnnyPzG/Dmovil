import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
