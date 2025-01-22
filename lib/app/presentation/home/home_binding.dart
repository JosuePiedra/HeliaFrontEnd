import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(apiRepository: Get.find()));
  }
}
