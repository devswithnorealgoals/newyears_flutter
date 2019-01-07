import 'package:shared_preferences/shared_preferences.dart';
import 'jwt.dart' as jwt;
import 'user.dart';

class Auth {
  // todo: use dispatch system to emit events when logged in/logged out
  // This is a singleton class
  User _currentUser;

  static final Auth _singleton = new Auth._internal();
  factory Auth() {
    return _singleton;
  }
  Auth._internal();

  void login(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> loggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<User> currentUser() async {
    if (_currentUser == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      Map<String, dynamic> payload = jwt.parseJwt(token);
      _currentUser = await User.show(payload['_id']);
    }
    return _currentUser;
  }
}
