import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get_connect.dart';

import 'package:get_storage/get_storage.dart';

class RankedClient extends GetConnect {
  static final RankedClient _instance = RankedClient._internal();
  factory RankedClient() => _instance;
  RankedClient._internal() {
    onInit();
  }

  @override
  void onInit() {
    httpClient.timeout = const Duration(minutes: 2);
    super.onInit();
  }

  Future<void> login(String user, pass) async {
    try {
      log(user);
      log(pass);
      var dio = Dio();
      var cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      dio.options.contentType = Headers.formUrlEncodedContentType;
      await dio.post(
        "https://admin.rankedgaming.com/accounts/game-logs.php",
        data: {'user': user, 'pass': pass},
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            responseType: ResponseType.json),
      );
      var cookies = await cookieJar.loadForRequest(Uri.parse("https://admin.rankedgaming.com/accounts/game-logs.php"));
      var key = cookies.firstWhere((e) => e.name == "key").value;
      var cookiesOne =
          'PHPSESSID=${cookies.firstWhere((element) => element.name == "PHPSESSID").value}; uid=${cookies.firstWhere((element) => element.name == "uid").value}; key=${cookies.firstWhere((element) => element.name == "key").value}; rem=0';
      await dio.get(
        'https://shop.rankedgaming.com/api/user/cross_login?auth=$user&key=${key.toString()}&intent=https%3A%2F%2Fadmin.rankedgaming.com%2Faccounts%2Fgame-logs.php',
        options: Options(
          headers: await _cookies(cookiesOne),
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      var cookiesTwo = await cookieJar.loadForRequest(Uri.parse("https://admin.rankedgaming.com/accounts/game-logs.php"));
      await _saveStorage(cookiesTwo, pass, user);
      var cookiesS = await _cookiesChanged();
      httpClient.addRequestModifier<dynamic>((request) {
        request.headers.addAll(cookiesS);
        return request;
      });
    } catch (e) {
      log('esto es el error ${e.toString()}');
      rethrow;
    }
  }

  Future<String?> getRooms() async {
    try {
      var data = await get('https://ladder.rankedgaming.com/index.php');
      return data.bodyString;
    } catch (e) {
      log(e.toString());
    }
  }
/////PARSE
  ///
  /// GEt Search by Id

  Future<String?> getGameDetailsById(String id, bool isDynamic) async {
    try {
      var url = 'https://admin.rankedgaming.com/rooms/game.php?game=dota&id=${id}';
      if (isDynamic) {
        url = 'https://admin.rankedgaming.com/rooms/game.php?game=dotadynamic&id=${id}';
      }
      var cookies = await _cookiesChanged();
      var data = await get(
        url,
        headers: cookies,
      );
      return data.bodyString;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isDynamic(int id, String player) async {
    try {
      var data = await get('https://ladder.rankedgaming.com/gameslist.php?room=${id.toString()}&uid=$player');
      if (data.bodyString!.contains('LOCAL')) return true;

      return false;
    } catch (e) {
      return false;
    }
  }

//https://ladder.rankedgaming.com/index.php?room=50&s=A_AZRAEL_L
// GLOBAL
  Future<String?> gameLogsGlobal(bool isdynamic) async {
    try {
      var cookies = await _cookiesChanged();
      var url = 'https://admin.rankedgaming.com/accounts/game-logs.php';
      if (isdynamic == true) {
        url = 'https://admin.rankedgaming.com/accounts/game-logs.php?game=dotadynamic';
      }
      var data = await post(url, null, headers: cookies);
      if (data.bodyString!.contains("Admin Panel") == false) {
        throw ('no login');
      }
      return data.bodyString;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> globalStatus(String nickname, int room) async {
    try {
      var data = await get('https://ladder.rankedgaming.com/index.php?room=${room.toString()}&s=$nickname');
      return data.bodyString;
    } catch (e) {
      rethrow;
    }
  }
}

// coookies
Future<Map<String, String>> _cookiesChanged() async {
  var cookies = GetStorage().read('cookies').toString().split(',');
  var cookie = <String>[];
  for (var item in cookies) {
    cookie.add('${item.split(';')[0]};');
  }
  cookie.add('shop_login=${cookie.last.toString().split("=")[1].toString()}');
  cookie[0] = cookie[0].toString().split('[')[1];
  for (var item in cookie) {
    if (item.contains('uid')) {
      await GetStorage().writeIfNull('uid', item.split('=')[1].split(';')[0]);
    }
  }
  return {
    'set-cookie': cookie[1],
    // ignore: equal_keys_in_map
    'set-cookie': cookie[2],
    // ignore: equal_keys_in_map
    'set-cookie': cookie[3],
    'cookie': cookie.join(),
  };
}

// LOGIN HELPERS
Future<void> _saveStorage(List<Cookie> cookies, String pass, user) async {
  for (var item in cookies) {
    item.expires = null;
    item.maxAge = 2147483647;
  }
  await GetStorage().write('cookies', cookies.toString());
  await GetStorage().writeIfNull('pass', pass.toString());
  await GetStorage().writeIfNull('user', user.toString());
}

Future<Map<String, dynamic>> _cookies(String token) async {
  return {
    'cookie': token,
    'accept': ' text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'es-419,es;q=0.9,es-ES;q=0.8,en;q=0.7,en-GB;q=0.6,en-US;q=0.5',
    'cache-control': 'max-age=0',
    'sec-fetch-dest': 'document',
    'sec-fetch-mode': 'navigate',
    'sec-fetch-site': ' same-site',
    'sec-fetch-user': '?1',
    'upgrade-insecure-requests': ' 1'
  };
}
