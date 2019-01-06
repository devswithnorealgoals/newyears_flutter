import 'package:shared_preferences/shared_preferences.dart';
import 'jwt.dart' as jwt;
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert';

class Auth {
  // todo: use dispatch system to emit events when logged in/logged out
  // This is a singleton class
  static final Auth _singleton = new Auth._internal();
  factory Auth() {
    return _singleton;
  }
  Auth._internal();

  void login(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    Map<String, dynamic> payload = jwt.parseJwt(token);

// todo: http interceptor to put header everywhere
// todo: improve
    final response = await http.get(globals.users_url + payload['_id'],
        headers: {"Authorization": "Bearer " + token});
    await prefs.setString('firstName', json.decode(response.body)['firstName']);
    await prefs.setString('lastName', json.decode(response.body)['lastName']);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // todo: improve
    await prefs.remove('token');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
  }

  Future<bool> loggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('token') != null;
  }
}
