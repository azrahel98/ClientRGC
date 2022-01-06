import 'package:get/instance_manager.dart';
import 'package:ranked/api/data/login.dart';
import 'package:ranked/app/pages/Login/controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(login: LoginImplementation()),
    );
  }
}
