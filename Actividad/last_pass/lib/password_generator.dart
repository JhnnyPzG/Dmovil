import 'package:flutter/material.dart';
import 'widgets.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Contraseñas'),
      ),
      body: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  double _passwordLength = 8;

  String _selectedOption = 'Todos los caracteres';
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              controller: passwordController,
              labelText: 'Contraseña',
              suffixIcon: Icons.copy,
              suffixIconOnPressed: copyToClipboard,
              refreshIconOnPressed: refreshPassword,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Longitud de la Contraseña:'),
                    Expanded(
                      child: Slider(
                        value: _passwordLength,
                        min: 4,
                        max: 20,
                        divisions: 16,
                        onChanged: (double value) {
                          setState(() {
                            _passwordLength = value;
                            generatePassword();
                          });
                        },
                      ),
                    ),
                    Text(_passwordLength.toInt().toString()),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Opciones de Generación:'),
                          RadioListTile(
                            title: Text('Fácil de decir'),
                            value: 'Fácil de decir',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('Fácil de leer'),
                            value: 'Fácil de leer',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('Todos los caracteres'),
                            value: 'Todos los caracteres',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Caracteres a Incluir:'),
                          CheckboxListTile(
                            title: Text('Mayúsculas'),
                            value: _includeUppercase,
                            onChanged: (bool? value) {
                              setState(() {
                                _includeUppercase = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Minúsculas'),
                            value: _includeLowercase,
                            onChanged: (bool? value) {
                              setState(() {
                                _includeLowercase = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Números'),
                            value: _includeNumbers,
                            onChanged: (bool? value) {
                              setState(() {
                                _includeNumbers = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Símbolos'),
                            value: _includeSymbols,
                            onChanged: (bool? value) {
                              setState(() {
                                _includeSymbols = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: generatePassword,
                    child: Text('Generar Contraseña'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void generatePassword() {
    String password = '';
    String characters = '';
    if (_includeUppercase) characters += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (_includeLowercase) characters += 'abcdefghijklmnopqrstuvwxyz';
    if (_includeNumbers) characters += '0123456789';
    if (_includeSymbols) characters += '!@#\$%^&*()_-+={}[]|;:,.<>?';

    if (_selectedOption == 'Fácil de decir') {
      password =
          _generatePronounceablePassword(_passwordLength.toInt(), characters);
    } else if (_selectedOption == 'Fácil de leer') {
      password = _generateReadablePassword(_passwordLength.toInt(), characters);
    } else {
      password = _generateRandomPassword(_passwordLength.toInt(), characters);
    }
    passwordController.text = password;
  }

  String _generatePronounceablePassword(int length, String characters) {
    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      password += characters[random.nextInt(characters.length)];
    }

    return password;
  }

  String _generateReadablePassword(int length, String characters) {
    Random random = Random();
    String password = '';

    bool uppercaseNext = true;
    for (int i = 0; i < length; i++) {
      if (uppercaseNext) {
        password += characters[random.nextInt(characters.length)].toUpperCase();
      } else {
        password += characters[random.nextInt(characters.length)].toLowerCase();
      }
      uppercaseNext = !uppercaseNext;
    }

    return password;
  }

  String _generateRandomPassword(int length, String characters) {
    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      password += characters[random.nextInt(characters.length)];
    }

    return password;
  }

  void copyToClipboard() {
    String generatedPassword = passwordController.text;
    Clipboard.setData(ClipboardData(text: generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contraseña copiada al portapapeles')),
    );
  }

  void refreshPassword() {
    generatePassword();
  }
}
