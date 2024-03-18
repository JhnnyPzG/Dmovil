import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? suffixIcon;
  final Function()? suffixIconOnPressed;
  final Function()? refreshIconOnPressed;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.refreshIconOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (suffixIcon != null)
              IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixIconOnPressed,
              ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refreshIconOnPressed,
            ),
          ],
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
