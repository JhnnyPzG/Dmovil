class CentroAsistencial {
  List<Map<String, dynamic>> pacientes;

  CentroAsistencial(this.pacientes);

  double porcentajeHombresSolteros() {
    int totalHombres =
        pacientes.where((paciente) => paciente["sexo"] == 1).length;
    int hombresSolteros = pacientes
        .where(
            (paciente) => paciente["sexo"] == 1 && paciente["estadoCivil"] == 1)
        .length;

    return (hombresSolteros / totalHombres) * 100;
  }

  double edadPromedioHombresCasados() {
    double sumaEdadesHombresCasados = 0;
    int totalHombresCasados = 0;

    pacientes.forEach((paciente) {
      if (paciente["sexo"] == 1 && paciente["estadoCivil"] == 2) {
        sumaEdadesHombresCasados += paciente["edad"];
        totalHombresCasados++;
      }
    });

    return totalHombresCasados != 0
        ? sumaEdadesHombresCasados / totalHombresCasados
        : 0;
  }

  double porcentajeMujeresSolteras() {
    int totalSolteros =
        pacientes.where((paciente) => paciente["estadoCivil"] == 1).length;
    int mujeresSolteras = pacientes
        .where(
            (paciente) => paciente["sexo"] == 2 && paciente["estadoCivil"] == 1)
        .length;

    return totalSolteros != 0 ? (mujeresSolteras / totalSolteros) * 100 : 0;
  }
}
