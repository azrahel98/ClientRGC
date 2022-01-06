import 'dart:developer';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/api/data/dashboard.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/app/settings/pages.dart';

class DashGlobalGamesController extends GetxController with StateMixin<List<GamesLine>> {
  DashboardImpl dash;
  DashGlobalGamesController({
    required this.dash,
  });

  @override
  void onReady() async {
    try {
      change(null, status: RxStatus.loading());

      var games = await dash.gamesinLineDynamic();
      change(games, status: RxStatus.success());
    } catch (e) {
      log(e.toString());
      if (e == 'no login') {
        Get.offAndToNamed(Routes.SPLASH, arguments: 'relogin');
      }

      change(null, status: RxStatus.loading());
    }
    super.onReady();
  }
}
