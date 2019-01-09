import 'package:flutter/material.dart';
import 'package:newyears_flutter/models/auth.dart';
import 'package:newyears_flutter/models/resolution.dart';
import 'package:newyears_flutter/models/user.dart';
import 'package:newyears_flutter/pages/login_page.dart';
import 'package:newyears_flutter/pages/settings_page.dart';

import 'app_state_container.dart';
import 'models/app_state.dart';
import 'pages/new-resolution_page.dart';
import 'pages/resolution_page.dart';

void main() => runApp(new AppStateContainer(
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomePage(),
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
  User _user;

  @override
  Widget build(BuildContext context) {
    appState = AppStateContainer.of(context).state;

    if (appState.authenticated) {
      return Scaffold(
          appBar: AppBar(title: Text('HOME'), actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ]),
          body: _buildResolutionList(),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewResolutionPage()));
              }));
    } else {
      return LoginPage();
    }
  }

  Widget _buildResolutionList() {
    _setUser();
    List<Resolution> resolutions = _user == null ? [] : _user.resolutions;
    return ListView(
        children: resolutions.map((res) {
      return ListTile(
        leading: Icon(Icons.map),
        title: Text(res.name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResolutionPage(res)),
          );
        },
      );
    }).toList());
  }

  void _setUser() async {
    User u = await Auth().currentUser();
    setState(() {
      _user = u;
    });
  }
}
