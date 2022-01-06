import 'package:ranked/api/domain/entities/chats/chat.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';

abstract class SearchRepository {
  Future<List<UserInGame>> getGameDetails(String id, bool isDynamic);
  Future<List<ChatinGame>> getChatGame(String id, bool isDisDynamic);
}
