import 'dart:convert';
import 'package:helia_frontend/app/data/models/medic_model.dart';
import 'package:helia_frontend/app/data/models/medical_central.dart';

MedicByMedicCentral medicByMedicCentralFromJson(String str) =>
    MedicByMedicCentral.fromJson(json.decode(str));

String medicByMedicCentralToJson(MedicByMedicCentral data) =>
    json.encode(data.toJson());

List<MedicByMedicCentral> medicByMedicCentraFromList(List<dynamic> listDynamic) =>
    List<MedicByMedicCentral>.from(listDynamic.map((x) => MedicByMedicCentral.fromJson(x)));

class MedicByMedicCentral {
  MedicalCentral establecimiento;
  List<Medic> medicos;

  MedicByMedicCentral({
    required this.establecimiento,
    required this.medicos,
  });

  factory MedicByMedicCentral.fromJson(Map<String, dynamic> json) =>
      MedicByMedicCentral(
        establecimiento: MedicalCentral.fromJson(json["establecimiento"]),
        medicos:
            List<Medic>.from(json["medicos"].map((x) => Medic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "establecimiento": establecimiento.toJson(),
        "medicos": List<dynamic>.from(medicos.map((x) => x.toJson())),
      };
}
