import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/global/global_rank.dart';
import 'package:ranked/api/domain/entities/rooms.dart';
import 'package:ranked/api/domain/entities/user.dart';

abstract class DashboardRepository {
  Future<List<Rooms>> getRooms();
  Future<void> saveRoom(Rooms room);
  Future<Rooms> getRoomSelect();
  Future<List<GamesLine>> gamesinLineglobal();
  Future<GlobalStatus> getGlobalStatus();
  Future<List<GamesLine>> gamesinLineDynamic();
  String user();
  Future<User> usuario();
}
