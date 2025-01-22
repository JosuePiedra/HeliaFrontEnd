class MedicalCentral {
  String id;
  String nombre;

  MedicalCentral({
    required this.id,
    required this.nombre,
  });

  factory MedicalCentral.fromJson(Map<String, dynamic> json) => MedicalCentral(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
