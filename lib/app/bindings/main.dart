import 'package:get/instance_manager.dart';
import 'package:ranked/app/theme/theme_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}
