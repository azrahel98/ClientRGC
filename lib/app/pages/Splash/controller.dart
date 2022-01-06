import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/api/repositories/login.dart';
import 'package:ranked/app/settings/pages.dart';

class SplashController extends GetxController {
  LoginRepository login;
  SplashController({required this.login});

  @override
  void onInit() async {
    await redirect();
    super.onInit();
  }

  redirect() async {
    switch (Get.arguments) {
      case 'relogin':
        await login.login(await login.user(), await login.password());
        Get.offAndToNamed(Routes.DASHBOARD);
        break;
      default:
        Get.offAndToNamed(
            await login.checkLogin() ? Routes.DASHBOARD : Routes.LOGIN);
    }
  }
}
