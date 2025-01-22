import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/data/models/medic_by_medic_central.dart';
import 'package:helia_frontend/app/data/models/medics_by_speciality.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_controller.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';

class DirectorioMedicoScreen extends GetView<ChatbotController> {
  const DirectorioMedicoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejempl

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Directorio Médico'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Por Centro Médico'),
              Tab(text: 'Por Especialidad'),
            ],
          ),
        ),
        body: Obx(() => TabBarView(
              children: [
                Container(
                  color: Colors.grey[100],
                  child: PorEstablecimientoView(
                      medic: controller.medicsByMedicalCentral.value),
                ),
                Container(
                    color: Colors.grey[100],
                    child: PorEspecialidadView(
                        medic: controller.medicsBySpeciality.value)),
              ],
            )),
      ),
    );
  }
}

class PorEstablecimientoView extends GetView<ChatbotController> {
  final List<MedicByMedicCentral> medic;

  const PorEstablecimientoView({super.key, required this.medic});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medic.length,
      itemBuilder: (context, index) {
        final establecimiento = medic[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          margin: const EdgeInsets.all(1),
          child: ExpansionTile(
            title: Text(establecimiento.establecimiento.nombre),
            children: establecimiento.medicos.map((medic) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  medic.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(medic.especialidad!),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  controller.selectDoctor.value = true;
                  controller.medicSelect.value = medic;
                  controller.medicName.value = medic.nombre;
                  controller.showTypingIndicator();
                  // Acción al presionar un elemento
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PorEspecialidadView extends GetView<ChatbotController> {
  final List<MedicBySpeciality> medic;

  const PorEspecialidadView({super.key, required this.medic});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medic.length,
      itemBuilder: (context, index) {
        final categoria = medic[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: Text(categoria.categoria),
            children: categoria.medicos.map((medic) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  medic.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(medic.costo.toString()),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  controller.selectDoctor.value = true;
                  controller.medicSelect.value = medic;
                  controller.medicName.value = medic.nombre;
                  controller.showTypingIndicator();
                  // Acción al presionar un elemento
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
