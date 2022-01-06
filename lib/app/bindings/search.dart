import 'package:get/instance_manager.dart';
import 'package:ranked/api/data/search.dart';
import 'package:ranked/app/pages/Search/controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(search: SearchImpl()));
  }
}
