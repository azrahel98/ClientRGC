import 'dart:developer';

import 'package:ranked/api/domain/entities/chats/chat.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';
import 'package:ranked/api/domain/services/hmtl.dart';
import 'package:ranked/api/domain/services/http.dart';
import 'package:ranked/api/repositories/search.dart';

class SearchImpl extends SearchRepository {
  var ranked = RankedClient();
  var html = ParseHtml.instance;

  @override
  Future<List<UserInGame>> getGameDetails(String id, bool isDynamic) async {
    try {
      var data = await ranked.getGameDetailsById(id, isDynamic);
      var result = html.parseUsersInGame(data!);
      return result;
    } catch (e) {
      log('pasado un error');
      return [];
    }
  }

  @override
  Future<List<ChatinGame>> getChatGame(String id, bool isDynamic) async {
    try {
      log('game id is $id y es dinamic? $isDynamic');
      var data = await ranked.getGameDetailsById(id, isDynamic);
      return await html.getChatinGame(data!);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
