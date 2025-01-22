import 'package:get/instance_manager.dart';
import 'package:helia_frontend/app/data/providers/api_provider.dart';
import 'package:helia_frontend/app/data/repositories/api_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiRepository>(
      ApiProvider(),
    );
  }
}
