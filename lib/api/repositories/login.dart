abstract class LoginRepository {
  Future<void> login(String user, String pass);
  Future<bool> checkLogin();
  Future<String> user();
  String password();
}
