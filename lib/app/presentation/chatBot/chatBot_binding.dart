import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_controller.dart';

class ChatbotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbotController>(
        () => ChatbotController(apiRepository: Get.find()));
  }
}
