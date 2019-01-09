import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newyears_flutter/globals.dart' as globals;

class Resolution {
  String name;
  int year;
  bool done;
  DateTime finishDate;
  List<String> tags;
  String type = 'goal'; // todo: use enum
  int count;
  int target;

  Resolution();
  Resolution.fromName(this.name);

  Resolution.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        done = json['done'],
        finishDate = json['finishDate'],
        // tags = json['tags'],
        type = json['type'],
        count = json['count'],
        target = json['target'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'year': (year ?? null).toString(),
        'type': type,
      };

  @override
  String toString() {
    return '$name';
  }

  Future<http.Response> create(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    return http.post(globals.base_url + 'users/' + userId + '/resolutions',
        body: this.toJson(), headers: {'Authorization': 'Bearer ' + token});
  }
}
