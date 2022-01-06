import 'package:get/instance_manager.dart';
import 'package:ranked/api/data/login.dart';
import 'package:ranked/app/pages/Splash/controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(login: LoginImplementation()),
    );
  }
}
