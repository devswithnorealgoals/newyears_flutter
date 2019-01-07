import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'resolution.dart';
import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  List<Resolution> resolutions;

  User(this.firstName, this.lastName, this.email, this.resolutions);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        resolutions = (json['resolutions'] as List).map((el) => Resolution.fromJson(el)).toList();

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'resolutions': resolutions
      };

  static Future<User> show(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(globals.users_url + id,
        headers: {'Authorization': 'Bearer ' + token});
    return User.fromJson(json.decode(response.body)['data']);
  }


}
