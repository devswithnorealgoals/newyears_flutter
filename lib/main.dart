import 'package:flutter/material.dart';
import 'login-page.dart';
import 'settings-page.dart';
import 'app_state_container.dart';
import 'models/app_state.dart';

void main() => runApp(new AppStateContainer(
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => SplashPage(),
        '/': (BuildContext context) => HomePage(),
        // '/splashscreen': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => LoginPage(),
        '/settings': (BuildContext context) => SettingsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  AppState appState;

  @override
  Widget build(BuildContext context) {
    appState = AppStateContainer.of(context).state;
    return appState.authenticated
        ? Scaffold(
            appBar: AppBar(title: Text('HOME'), actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ]),
            body: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Map'),
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Album'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
              ],
            ),
          )
        : LoginPage();
  }
}
