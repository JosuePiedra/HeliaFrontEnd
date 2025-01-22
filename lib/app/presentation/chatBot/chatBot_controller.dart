import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:helia_frontend/app/data/models/api_response_model.dart';
import 'package:helia_frontend/app/data/models/medic_by_medic_central.dart';
import 'package:helia_frontend/app/data/models/medic_model.dart';
import 'package:helia_frontend/app/data/models/medics_by_speciality.dart';
import 'package:helia_frontend/app/data/models/reminder_conult_model.dart';
import 'package:helia_frontend/app/data/models/reminder_model.dart';
import 'package:helia_frontend/app/data/repositories/api_repository.dart';

class ChatbotController extends GetxController {
  final ApiRepository apiRepository;
  final RxList<types.Message> messages = <types.Message>[].obs;
  final TextEditingController textEditingController = TextEditingController();
  RxList<Reminder> reminders = <Reminder>[].obs;
  RxList<Consult> consults = <Consult>[].obs;
  final user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final bot = const types.User(id: 'bot');
  String? chatId;
  RxBool selectDoctor = false.obs;
  RxString medicName = ''.obs;
  RxBool waitingResponse = false.obs;
  RxInt seleccionadoValor = 0.obs;

  //medicos
  Rxn<Medic> medicSelect = Rxn<Medic>();
  RxList<MedicBySpeciality> medicsBySpeciality = <MedicBySpeciality>[].obs;
  RxList<MedicByMedicCentral> medicsByMedicalCentral =
      <MedicByMedicCentral>[].obs;

  RxList<Medic> frecuentMedic = <Medic>[].obs;

  ChatbotController({
    required this.apiRepository,
  });

  // Método para enviar el mensaje del usuario
  void handleSendPressed(types.PartialText text) {
    final userMessage = types.TextMessage(
      id: randomString(),
      author: user,
      text: text.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    messages.insert(0, userMessage);

    // Mostrar "escribiendo..." mientras se espera la respuesta
    showTypingIndicator();
  }

  // Simula el delay al recibir la respuesta del backend
  Future<void> showTypingIndicator() async {
    final typingMessage = types.TextMessage(
      id: 'typing',
      author: bot,
      text: 'Escribiendo...',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    waitingResponse.value = true;

    // Simula la espera de la respuesta del backend
    messages.insert(0, typingMessage);

    String prompt = textEditingController.text;

    if (seleccionadoValor != 0) {
      if (seleccionadoValor == 1) {
        prompt = "Quiero agregar una recordatorio médico";
      } else if (seleccionadoValor == 2) {
        prompt = "Quiero agendar una consulta médica";
      } else if (seleccionadoValor == 3) {
        prompt = "Te haré una pregunta médica";
      }
    }
    seleccionadoValor.value = 0;

    if (selectDoctor.value) {
      prompt =
          "El médico seleccionado es ${medicSelect.value!.nombre} y su id es: ${medicSelect.value!.id}";

      selectDoctor.value = false;
    }

    ApiResponseModel response = await apiRepository.getResponse(prompt, chatId);

    chatId = await response.data['chatId'];

    // Remover "Escribiendo..."
    messages.removeWhere((message) => message.id == 'typing');

    if (response.status == 200) {
      final botResponse = types.TextMessage(
        id: randomString(),
        author: bot,
        text: response.data['response'],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      messages.insert(0, botResponse);
    } else if (response.status == 205) {
      // Crear recordatorio y asociarlo con el mensaje
      final reminder = Reminder.fromJson(response.data['reminder']);
      reminders.add(reminder);

      final customMessage = types.CustomMessage(
        id: randomString(),
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: {
          'type': 'special 1',
          'reminderIndex': reminders.length - 1, // Índice del recordatorio
        },
      );

      messages.insert(0, customMessage);
    } else if (response.status == 206) {
      // Crear recordatorio y asociarlo con el mensaje
      final consulta = Consult.fromJson(response.data['consulta']);
      consults.add(consulta);

      final customMessage = types.CustomMessage(
        id: randomString(),
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: {
          'type': 'consulta',
          'consultIndex': consults.length - 1, // Índice del recordatorio
        },
      );

      messages.insert(0, customMessage);
    } else if (response.status == 201) {
      final customMessage = types.CustomMessage(
        id: randomString(),
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: {
          'type': 'special 2',
          'response': response.data['response'],
        },
      );

      messages.insert(0, customMessage);
    } else if (response.status == 404) {
      final customMessage = types.CustomMessage(
        id: randomString(),
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: {
          'type': 'no soportada',
          'response': response.data['response'],
        },
      );

      messages.insert(0, customMessage);
    } else if (response.status == 210) {
      medicsBySpeciality.value =
          medicBySpecialityFromList(response.data['medicsBySpeciality']);

      medicsByMedicalCentral.value =
          medicByMedicCentraFromList(response.data['medicsByMedicCentral']);

      frecuentMedic.value = medicFromList(response.data['frecuentMedics']);

      final customMessage = types.CustomMessage(
        id: randomString(),
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: {
          'type': 'medicos',
          'response': response.data['response'],
        },
      );
      messages.insert(0, customMessage);
    }
    waitingResponse.value = false;
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
