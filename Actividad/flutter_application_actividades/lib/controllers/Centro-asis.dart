import 'package:flutter_application_actividades/models/CentroAsis.dart';
import 'dart:io';

void main() {
  stdout.write("Ingrese el número de pacientes: ");
  int numPacientes = int.parse(stdin.readLineSync()!);

  List<Map<String, dynamic>> pacientes = [];

  for (int i = 0; i < numPacientes; i++) {
    stdout.write("Ingrese el sexo del paciente ${i + 1} (1. Hombre, 2. Mujer): ");
    int sexo = int.parse(stdin.readLineSync()!);

    stdout.write(
        "Ingrese el estado civil del paciente ${i + 1} (1. Soltero, 2. Casado, 3. Viudo): ");
    int estadoCivil = int.parse(stdin.readLineSync()!);

    stdout.write("Ingrese la edad del paciente ${i + 1}: ");
    int edad = int.parse(stdin.readLineSync()!);

    pacientes.add({"sexo": sexo, "estadoCivil": estadoCivil, "edad": edad});
  }

  CentroAsistencial centro = CentroAsistencial(pacientes);

  print(
      "Porcentaje de hombres solteros: ${centro.porcentajeHombresSolteros()}%");
  print(
      "Edad promedio de hombres casados: ${centro.edadPromedioHombresCasados()} años");
  print(
      "Porcentaje de mujeres solteras: ${centro.porcentajeMujeresSolteras()}%");
}
