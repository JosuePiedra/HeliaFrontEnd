// To parse this JSON data, do
//
//     final medic = medicFromJson(jsonString);

import 'dart:convert';

Medic medicFromJson(String str) => Medic.fromJson(json.decode(str));

String medicToJson(Medic data) => json.encode(data.toJson());

List<Medic> medicFromList(List<dynamic> listDynamic) =>
    List<Medic>.from(listDynamic.map((x) => Medic.fromJson(x)));

class Medic {
  String id;
  String? ci;
  String? especialidad;
  String nombre;
  int? costo;

  Medic({
    required this.id,
    required this.ci,
    required this.especialidad,
    required this.nombre,
    required this.costo,
  });

  factory Medic.fromJson(Map<String, dynamic> json) => Medic(
        id: json["id"],
        ci: json["CI"],
        especialidad: json["especialidad"],
        nombre: json["nombre"],
        costo: json["costo"],);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CI": ci,
        "especialidad": especialidad,
        "Nombre": nombre,
        "Costo": costo,
      };
}
