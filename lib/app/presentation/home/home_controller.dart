import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:helia_frontend/app/data/models/reminder_conult_model.dart';
import 'package:helia_frontend/app/data/models/reminder_model.dart';
import 'package:helia_frontend/app/data/repositories/api_repository.dart';
import 'package:helia_frontend/app/utils/exceptions/http_exception.dart';

class HomeController extends GetxController {
  final Rx<bool> select = false.obs;
  RxList<bool> status = <bool>[].obs;
  ApiRepository apiRepository;
  RxList<Reminder> reminders = <Reminder>[].obs;
  RxList<Consult> consults = <Consult>[].obs;
  RxList<Consult> futureConsults = <Consult>[].obs;
  RxList<Consult> previousConsults = <Consult>[].obs;
  RxBool showMoreAppointments = false.obs;
  DateTime selectedDate = DateTime.now();
  HomeController({required this.apiRepository});

  @override
  void onInit() {
    super.onInit();
    getReminder();
    getCitasMedicas();
  }

  Future<void> getReminder() async {
    try {
      var response =
          await apiRepository.getReminders("67773072b13a56e7e498ec93");

      switch (response.status) {
        case 200:
          reminders.value = reminderFromList(response.data);

          reminders.forEach((e) =>
              e.isComplete == true ? status.add(true) : status.add(false));

          print(reminders.length);
          break;
        default:
          break;
      }
    } on UnauthorizedException {
      BotToast.cleanAll();
      BotToast.showText(text: "Sesión caducada");
    } on TimeoutException {
      BotToast.cleanAll();
      BotToast.showText(
          text: "Tiempo de espera agotado",
          duration: const Duration(seconds: 2));
    } on SocketException {
      BotToast.cleanAll();
      BotToast.showText(
          text: "Error de conexión", duration: const Duration(seconds: 2));
    } catch (error, stack) {
      print(error);
    }
  }

  Future<void> getCitasMedicas() async {
    try {
      var response = await apiRepository.getConsult("67773072b13a56e7e498ec93");

      switch (response.status) {
        case 200:
          consults.value = consultFromList(response.data);
          consults.forEach((e) => e.fecha.isAfter(DateTime.now())
              ? futureConsults.add(e)
              : previousConsults.add(e));

          print(previousConsults.length);

          break;
        default:
          break;
      }
    } on UnauthorizedException {
      BotToast.cleanAll();
      BotToast.showText(text: "Sesión caducada");
    } on TimeoutException {
      BotToast.cleanAll();
      BotToast.showText(
          text: "Tiempo de espera agotado",
          duration: const Duration(seconds: 2));
    } on SocketException {
      BotToast.cleanAll();
      BotToast.showText(
          text: "Error de conexión", duration: const Duration(seconds: 2));
    } catch (error, stack) {
      print(error);
    }
  }
}
