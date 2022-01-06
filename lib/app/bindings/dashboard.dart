import 'package:get/instance_manager.dart';
import 'package:ranked/api/data/dashboard.dart';
import 'package:ranked/app/pages/Dashboard/controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(dash: DashboardImpl()));
    //Get.put(DashGlobalGamesController(dash: DashboardImpl()));
  }
}
