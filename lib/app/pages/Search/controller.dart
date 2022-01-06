import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';
import 'package:ranked/api/repositories/search.dart';

class SearchController extends GetxController with StateMixin<List<UserInGame>> {
  GamesLine? gameSelect;
  SearchRepository search;
  bool? isDynamic;

  SearchController({required this.search}) {
    gameSelect = Get.arguments[0] as GamesLine;
    isDynamic = Get.arguments[1] as bool;
  }
  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    var users = await search.getGameDetails(gameSelect!.gameId!, isDynamic!);
    change(users, status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
