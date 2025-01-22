// To parse this JSON data, do
//
//     final consulta = consultaFromJson(jsonString);

import 'dart:convert';

Consult consultaFromJson(String str) => Consult.fromJson(json.decode(str));

String consultToJson(Consult data) => json.encode(data.toJson());

List<Consult> consultFromList(List<dynamic> listDynamic) =>
    List<Consult>.from(listDynamic.map((x) => Consult.fromJson(x)));

class Consult {
  String id;
  String tipo;
  DateTime fecha;
  String estado;
  String medicoId;
  String medico;
  String doctorSpeciality;

  Consult(
      {required this.id,
      required this.tipo,
      required this.fecha,
      required this.estado,
      required this.medico,
      required this.doctorSpeciality,
      required this.medicoId});

  factory Consult.fromJson(Map<String, dynamic> json) => Consult(
        id: json["_id"],
        tipo: json["tipo"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        medico: json["medico"],
        doctorSpeciality: json["medicoEspecialidad"],
        medicoId: json["medicoId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tipo": tipo,
        "fecha": fecha.toIso8601String(),
        "estado": estado,
        "medico": medico,
      };
}

class Receta {
  dynamic medicamentos;

  Receta({
    required this.medicamentos,
  });

  factory Receta.fromJson(Map<String, dynamic> json) => Receta(
        medicamentos: json["medicamentos"],
      );

  Map<String, dynamic> toJson() => {
        "medicamentos": medicamentos,
      };
}
