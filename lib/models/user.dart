import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import 'resolution.dart';
import 'dart:convert';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  List<Resolution> resolutions;

  User();

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        resolutions = (json['resolutions'] as List)
            .map((el) => Resolution.fromJson(el))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'resolutions': resolutions
      };

  static Future<User> show(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(globals.users_url + id,
        headers: {'Authorization': 'Bearer ' + token});
    return User.fromJson(json.decode(response.body)['data']);
  }

  Future<http.Response> create() {
    return http.post(globals.signup_url, body: {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "email": this.email,
      "password": this.password
    });
  }
}
