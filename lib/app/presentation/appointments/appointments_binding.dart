import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/appointments/appointments_controller.dart';

class AppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentController>(
        () => AppointmentController(apiRepository: Get.find()));
  }
}
