import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/user.dart';
import 'package:ranked/api/repositories/dashboard.dart';

class DashboardController extends GetxController with StateMixin {
  DashboardRepository dash;
  DashboardController({required this.dash});
  final pageController = PageController(initialPage: 0, keepPage: true);
  List<GamesLine>? gamesglobal;
  List<GamesLine>? gamesDynamic;

  User? usuario;

  RxInt tabCurrent = 0.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    usuario = await dash.usuario();
    usuario!.nickname = dash.user();
    gamesglobal = await dash.gamesinLineglobal();
    gamesDynamic = [];
    change(null, status: RxStatus.success());
    super.onInit();
  }

  changeIndex(int i) {
    switch (i) {
      case 0:
        tabCurrent.value = i;
        pageController.animateToPage(i, duration: const Duration(seconds: 1), curve: Curves.easeInQuad);

        break;
      case 1:
        tabCurrent.value = i;
        pageController.animateToPage(i, duration: const Duration(seconds: 1), curve: Curves.easeInQuad);

        break;
      default:
        tabCurrent.value = 0;
    }
  }

  changeThema() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    update(['menu']);
  }
}
