import 'package:get_storage/get_storage.dart';
import 'package:ranked/api/domain/services/http.dart';
import 'package:ranked/api/repositories/login.dart';

class LoginImplementation extends LoginRepository {
  var ranked = RankedClient();
  var box = GetStorage();
  @override
  Future<bool> checkLogin() async {
    if (box.read('user') != null && box.read('pass') != null) return true;
    return false;
  }

  @override
  Future<void> login(String user, String pass) async {
    try {
      await ranked.login(user, pass);
    } catch (e) {
      rethrow;
    }
  }

  @override
  String password() => box.read('pass').toString();

  @override
  Future<String> user() async {
    return await box.read('user');
  }
}
