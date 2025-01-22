import 'dart:convert';

import 'package:helia_frontend/app/data/models/medic_model.dart';

MedicBySpeciality medicBySpecialityFromJson(String str) =>
    MedicBySpeciality.fromJson(json.decode(str));

String medicBySpecialityToJson(MedicBySpeciality data) =>
    json.encode(data.toJson());

List<MedicBySpeciality> medicBySpecialityFromList(List<dynamic> listDynamic) =>
    List<MedicBySpeciality>.from(
        listDynamic.map((x) => MedicBySpeciality.fromJson(x)));

class MedicBySpeciality {
  String categoria;
  List<Medic> medicos;

  MedicBySpeciality({
    required this.categoria,
    required this.medicos,
  });

  factory MedicBySpeciality.fromJson(Map<String, dynamic> json) =>
      MedicBySpeciality(
        categoria: json["categoria"],
        medicos:
            List<Medic>.from(json["medicos"].map((x) => Medic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoria": categoria,
        "medicos": List<dynamic>.from(medicos.map((x) => x.toJson())),
      };
}
