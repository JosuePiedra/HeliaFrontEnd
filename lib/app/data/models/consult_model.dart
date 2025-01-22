// To parse this JSON data, do
//
//     final consulta = consultaFromJson(jsonString);

import 'dart:convert';

Consulta consultaFromJson(String str) => Consulta.fromJson(json.decode(str));

String consultaToJson(Consulta data) => json.encode(data.toJson());

List<Consulta> consultFromList(List<dynamic> listDynamic) =>
    List<Consulta>.from(listDynamic.map((x) => Consulta.fromJson(x)));

class Consulta {
  String id;
  String tipo;
  DateTime? fecha;
  String paciente;
  String? receta;
  List<List<String>>? examenesLaboratorio;
  String estado;
  Medico medico;
  Establecimiento? establecimiento;

  Consulta({
    required this.id,
    required this.tipo,
    required this.fecha,
    required this.paciente,
    required this.receta,
    required this.examenesLaboratorio,
    required this.estado,
    required this.medico,
    required this.establecimiento,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) => Consulta(
        id: json["_id"],
        tipo: json["tipo"],
        fecha: DateTime.parse(json["fecha"]),
        paciente: json["paciente"],
        receta: json["receta"],
        examenesLaboratorio: List<List<String>>.from(json["examenesLaboratorio"]
            .map((x) => List<String>.from(x.map((x) => x)))),
        estado: json["estado"],
        medico: Medico.fromJson(json["medico"]),
        establecimiento: Establecimiento.fromJson(json["establecimiento"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tipo": tipo,
        "fecha": fecha?.toIso8601String(),
        "paciente": paciente,
        "receta": receta,
        "examenesLaboratorio": List<dynamic>.from(examenesLaboratorio
            !.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "estado": estado,
        "medico": medico.toJson(),
        "establecimiento": establecimiento?.toJson(),
      };
}

class Establecimiento {
  Establecimiento();

  factory Establecimiento.fromJson(Map<String, dynamic> json) =>
      Establecimiento();

  Map<String, dynamic> toJson() => {};
}

class Medico {
  String nombre;
  String especialidad;
  Costo costo;

  Medico({
    required this.nombre,
    required this.especialidad,
    required this.costo,
  });

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
        nombre: json["nombre"],
        especialidad: json["especialidad"],
        costo: Costo.fromJson(json["costo"]),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "especialidad": especialidad,
        "costo": costo.toJson(),
      };
}

class Costo {
  String numberDecimal;

  Costo({
    required this.numberDecimal,
  });

  factory Costo.fromJson(Map<String, dynamic> json) => Costo(
        numberDecimal: json["\u0024numberDecimal"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024numberDecimal": numberDecimal,
      };
}
