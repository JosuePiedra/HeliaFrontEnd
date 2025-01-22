import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/data/models/medic_model.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_controller.dart';

class MedicContainer extends GetView<ChatbotController> {
  final Medic medic;

  const MedicContainer({super.key, required this.medic});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(
        medic.nombre,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(medic.especialidad!),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        controller.medicName.value = medic.nombre;  
        controller.selectDoctor.value = true;
        controller.medicSelect.value = medic;
        controller.showTypingIndicator();
        // Acción al presionar un elemento
      },
    );
  }
}
