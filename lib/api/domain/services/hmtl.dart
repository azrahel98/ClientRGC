import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:ranked/api/domain/entities/chats/chat.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/global/global_rank.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';
import 'package:ranked/api/domain/entities/user.dart';

class ParseHtml {
  ParseHtml._internal();

  static final ParseHtml _instance = ParseHtml._internal();
  static ParseHtml get instance => _instance;

  Future<Map<String, String>> saveRooms(String body) async {
    var doc = parse(body);
    var selector = doc.querySelector('#select-channel > dd > ul');
    var items = selector!.getElementsByTagName('a');
    var data = <String, String>{};
    for (var item in items) {
      var key = item.attributes['href'].toString().split('room=')[1].trim();
      data.addAll({item.text.trim(): key});
    }

    return data;
  }

  Future<GlobalStatus?> parseGlobalStatus(String response) async {
    var doc = parse(response);
    var data = <String>[];
    var count = doc.getElementsByTagName('#gamespage > div > div.row.animate > a > div');
    for (var item in count) {
      data.add(item.text.trim());
    }
    var loss = count[3].getElementsByTagName('div')[1].attributes['onmouseover'].toString();
    var winds = count[3].getElementsByTagName('div').first.attributes['onmouseover'].toString();

    data.add(loss.split('LOSSES')[0].split("'")[1].trim());
    data.add(winds.split('WINS')[0].split("'")[1].trim());
    for (var item in data) {
      log(item.toString());
    }
    return GlobalStatus.fromList(data);
  }

  Future<List<GamesLine>?> fetchGames(String response, bool isdynamic) async {
    var doc = parse(response);
    var d = doc.querySelector('body > div.wrapper > section > div > div.row.m-t-lg > div > div > div > div > div > div > div > table > tbody');
    var xd = d!.getElementsByTagName('tr');
    var lista = <GamesLine>[];
    for (var item in xd) {
      var game = <String>[];
      for (var value in item.getElementsByTagName('td')) {
        game.add(value.text);
      }
      var buscar = item.getElementsByTagName('div');
      game.add(buscar.first.attributes['title'].toString());
      var gamedt = GamesLine.fromList(game, isdynamic);
      if (!isdynamic) {
        gamedt.urlPath = await getStringPath(game[12]);
        lista.add(gamedt);
      }
      if (isdynamic) {
        gamedt.urlPath = await getStringPath(game[15]);
        lista.add(gamedt);
      }
    }
    return lista;
  }

  Future<List<UserInGame>> parseUsersInGame(String response) async {
    try {
      var doc = parse(response);

      var data = <UserInGame>[];
      var div = doc.querySelector('body > div.wrapper > section > div');

      var radiant = div!.children[1].children[0].getElementsByTagName('div > div > table > tbody > tr');
      for (var item in radiant) {
        var countr = item.getElementsByTagName('td')[3].getElementsByTagName('img');
        data.add(
          UserInGame(
            nickname: item.getElementsByTagName('td')[3].text,
            status: item.getElementsByTagName('td')[7].text,
            country: countr.isEmpty ? '' : countr.first.attributes['src'].toString(),
            a: int.parse(item.getElementsByTagName('td')[6].text),
            d: int.parse(item.getElementsByTagName('td')[5].text),
            k: int.parse(item.getElementsByTagName('td')[4].text),
          ),
        );
      }
      var dire = div.children[1].children[1].getElementsByTagName('div > div > table > tbody > tr');
      for (var item in dire) {
        var countr = item.getElementsByTagName('td')[3].getElementsByTagName('img');
        data.add(
          UserInGame(
            team: 1,
            nickname: item.getElementsByTagName('td')[3].text.trim(),
            status: item.getElementsByTagName('td')[7].text,
            country: countr.isEmpty ? '' : countr.first.attributes['src'].toString(),
            a: int.parse(item.getElementsByTagName('td')[6].text),
            d: int.parse(item.getElementsByTagName('td')[5].text),
            k: int.parse(item.getElementsByTagName('td')[4].text),
          ),
        );
      }
      return data;
    } catch (e) {
      return <UserInGame>[];
    }
  }

  Future<List<ChatinGame>> getChatinGame(String response) async {
    try {
      var doc = parse(response);
      var chats = <ChatinGame>[];
      var div = doc.querySelector('body > div.wrapper > section > div');
      var div2 = div!.children[2].children[1];
      var table = div2.getElementsByTagName('table > tbody > tr');
      for (var item in table) {
        var chatline = item.getElementsByTagName('td');
        chats.add(ChatinGame(time: chatline[0].text, nickname: chatline[2].text, chatTipe: chatline[1].text, message: chatline[3].text));
      }
      return chats;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveNickname(String response) async {
    var doc = parse(response);
    var d = doc.querySelector('body > div.wrapper > section > div');
    var xd = d!.getElementsByTagName('div:nth-child(2)');
    for (var item in xd) {
      var xdv = item.getElementsByTagName('div:nth-child(2) > div > div');
      for (var xds in xdv) {
        var lis = xds.text.split(' ');
        await GetStorage().writeIfNull('nickname', lis[0].split('RGID')[0].toString());
        log(xds.text.toString());
      }
    }
  }

  Future<User?> getUser(String response) async {
    var usuario = <String>[];
    var doc = parse(response);
    var d = doc.querySelector('body > div.wrapper > section > div');
    var xd = d!.getElementsByTagName('div:nth-child(2)');
    for (var item in xd) {
      var xdv = item.getElementsByTagName('div:nth-child(2) > div > div');
      for (var xds in xdv) {
        var lis = xds.text.split(' ');
        var result = lis.first.substring(0, lis.first.length - 4);
        for (var q in lis) {
          usuario.add(q.toString());
        }
        usuario.add(result);
        var imag = xds.getElementsByTagName('img');
        usuario.add(imag.first.attributes['src'].toString());
      }
    }
    usuario.last.trim();

    return User.fromList(usuario);
  }
}

Future<String?> getStringPath(String name) async {
  var url = 'https://azrahelfiles.s3.amazonaws.com/';
  switch (name) {
    case 'Phantom Assassin':
      return '${url}mortred.png';
    case 'Butcher':
      return '${url}pudge.png';
    case 'Lifestealer':
      return '${url}naix.png';
    case 'Silencer':
      return '${url}northom.png';
    case 'Lich':
      return '${url}lich.png';
    case 'Vengeful Spirit':
      return '${url}vengue.png';
    case 'Gyrocopter':
      return '${url}giro.png';
    case 'Monkey King':
      return '${url}monkey.png';
    case 'Witch Doctor':
      return '${url}wicho.png';
    case 'Faerie Dragon':
      return '${url}puck.png';
    case 'Ember Spirit':
      return '${url}ember.png';
    case 'Geomancer':
      return '${url}meppo.png';
    case 'Legion Commander':
      return '${url}legion.png';
    case 'Juggernaut':
      return '${url}jurnero.png';
    case 'Gorgon':
      return '${url}medusa.png';
    case 'Stealth Assasin':
      return '${url}riki.png';
    case 'Sand King':
      return '${url}sanking.png';
    case 'Rogue Knight':
      return '${url}sven.png';
    case 'Tidehunter':
      return '${url}tide.png';
    case 'Earthshaker':
      return '${url}toro.png';
    case 'Night Stalker':
      return '${url}balanar.png';
    case 'Grand Magus':
      return '${url}rubick.png';
    case 'Slithereen Guard':
      return '${url}slardar.png';
    case 'Admiral':
      return '${url}kunka.png';
    case 'Windrunner':
      return '${url}aleria.png';
    case 'Tuskarr':
      return '${url}tuskar.png';
    case 'Murloc Nightcrawler':
      return '${url}sapo.png';
    case 'Bounty Hunter':
      return '${url}gondar.png';
    case 'Stone Giant':
      return '${url}tiny.png';
    case 'Dwarven Sniper':
      return '${url}sniper.png';
    case 'Stealth Assassin':
      return '${url}riki.png';
    case 'Shadow Fiend':
      return '${url}never.png';
    case 'Tormented Soul':
      return '${url}lesrac.png';
    case 'Earth Spirit':
      return '${url}earth.png';
    case 'Winter Wyvern':
      return '${url}winter.png';
    case 'Void':
      return '${url}void.png';
    case 'Prophet':
      return '${url}furion.png';
    case 'Clockwerk Goblin':
      return '${url}clock.png';
    case 'Dragon Knight':
      return '${url}dk.png';
    case 'Tinker':
      return '${url}tinker.png';
    case 'Morphling':
      return '${url}morphing.png';
    case 'Doom Bringer':
      return '${url}doom.png';
    case 'Nerubian Weaver':
      return '${url}weaver.png';
    case 'Batrider':
      return '${url}batrider.png';
    case 'Bloodseeker':
      return '${url}blood.png';
    case 'Beastmaster':
      return '${url}rexar.png';
    case 'Queen of Pain':
      return '${url}queen.png';
    case 'Lord of Olympia':
      return '${url}zeus.png';
    case 'Lightning Revenant':
      return '${url}razor.png';
    default:
      return '${url}sapo.png';
  }
}
