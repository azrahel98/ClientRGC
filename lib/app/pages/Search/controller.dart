import 'dart:developer';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/api/domain/entities/chats/chat.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';
import 'package:ranked/api/repositories/search.dart';

class SearchController extends GetxController with StateMixin<List<UserInGame>> {
  GamesLine? gameSelect;
  SearchRepository search;
  bool? isDynamic;
  RxBool showChat = false.obs;
  List<ChatinGame> chats = [];

  SearchController({required this.search}) {
    gameSelect = Get.arguments[0] as GamesLine;
    isDynamic = Get.arguments[1] as bool;
  }

  @override
  void onReady() async {
    try {
      change(null, status: RxStatus.loading());
      log(isDynamic.toString());
      var users = await search.getGameDetails(gameSelect!.gameId!, isDynamic!);
      change(users, status: RxStatus.success());
      super.onReady();
    } catch (e) {
      log('erorr');
      log(e.toString());
    }
  }

  getChats() async {
    chats = await search.getChatGame(gameSelect!.gameId!, Get.arguments[1]);
    showChat.value = !showChat.value;
  }
}
