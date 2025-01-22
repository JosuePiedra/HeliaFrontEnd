import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/appointments/appointments_binding.dart';
import 'package:helia_frontend/app/presentation/appointments/appointments_page.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_binding.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_page.dart';
import 'package:helia_frontend/app/presentation/home/home_binding.dart';
import 'package:helia_frontend/app/presentation/home/home_page.dart';
part './app_routes.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(
        name: Routes.home, page: () => HomePage(), bindings: [HomeBinding()]),
    GetPage(
        name: Routes.chatBot,
        page: () => ChatbotPage(),
        bindings: [ChatbotBinding()]),
    GetPage(
        name: Routes.appointments,
        page: () => AppointmentsPage(),
        bindings: [AppointmentBinding()])
  ];
}
