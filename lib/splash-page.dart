import 'package:flutter/material.dart';
import 'auth.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth().loggedIn().then((loggedIn) {
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
