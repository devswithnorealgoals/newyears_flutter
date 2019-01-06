import 'package:flutter/material.dart';
import 'login-page.dart';
import 'splash-page.dart';
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashPage(),
        '/home': (BuildContext context) => HomePage(),
        // '/splashscreen': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => LoginPage()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Column(children: <Widget>[
        Text("This is home."),
        RaisedButton(
          child: Text("Logout"),
          onPressed: () {
            Auth().logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        )
      ]),
    );
  }
}
