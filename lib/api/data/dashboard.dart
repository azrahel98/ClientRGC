import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/global/global_rank.dart';
import 'package:ranked/api/domain/entities/rooms.dart';
import 'package:ranked/api/domain/entities/user.dart';
import 'package:ranked/api/domain/services/hmtl.dart';
import 'package:ranked/api/domain/services/http.dart';
import 'package:ranked/api/repositories/dashboard.dart';

class DashboardImpl extends DashboardRepository {
  var ranked = RankedClient();
  var html = ParseHtml.instance;
  var box = GetStorage();

  @override
  Future<List<Rooms>> getRooms() async {
    var data = await rootBundle.loadString('assets/json/rooms.json');
    var js = json.decode(data) as Map;
    var rooms = <Rooms>[];
    js.forEach((key, value) {
      rooms.add(Rooms(name: key, key: int.parse(value)));
    });
    return rooms;
  }

  @override
  Future<void> saveRoom(Rooms room) async {
    await box.write('room', room.key);
    await box.write('roomname', room.name);
  }

  @override
  Future<Rooms> getRoomSelect() async {
    var rooms = await getRooms();
    var id = await box.read('room');
    return rooms.firstWhere((element) => element.key = id);
  }

  @override
  Future<List<GamesLine>> gamesinLineglobal() async {
    try {
      var data = await ranked.gameLogsGlobal(false);
      html.saveNickname(data!);
      var list = await html.fetchGames(data, false);
      return list!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GlobalStatus> getGlobalStatus() async {
    try {
      var games = await ranked.globalStatus(box.read('nickname'), box.read('room'));
      var parse = await html.parseGlobalStatus(games!);
      return parse!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GamesLine>> gamesinLineDynamic() async {
    try {
      var data = await ranked.gameLogsGlobal(true);
      html.saveNickname(data!);
      var list = await html.fetchGames(data, true);
      return list!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  String user() => box.read('user');

  @override
  Future<User> usuario() async {
    try {
      var data = await ranked.gameLogsGlobal(false);
      var usuario = await html.getUser(data!);
      return usuario!;
    } catch (e) {
      rethrow;
    }
  }
}
