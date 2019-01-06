import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  Future<bool> checkIfAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = (prefs.getBool('loggedIn') ?? false);
    return loggedIn;
  }

  @override
  Widget build(BuildContext context) {
    checkIfAuthenticated().then((loggedIn) {
      if (loggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return new Scaffold(
      body: new Center(
        child: Text("SPLASH SCREEN"),
      ),
    );
  }
}
