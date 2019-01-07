import 'package:flutter/material.dart';
import 'auth.dart';
import 'user.dart';
import 'app_state_container.dart';

// todo: move login methods to its own class

class SettingsPage extends StatefulWidget {
  @override
  SettingsState createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _user;

  @override
  Widget build(BuildContext context) {
    final container = AppStateContainer.of(context);
    _getUser();
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _user == null ? null : Text("First name: " + _user.firstName),
            _user == null ? null : Text("Last name: " + _user.lastName),
            _user == null ? null : Text("Email: " + _user.email),
            _user == null
                ? null
                : Text("Resolutions: " + _user.resolutions.toString()),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () async {
                Auth().logout();
                container.logout();
                Navigator.pop(context); // todo: why do i need this here
              },
            )
          ].where((o) => o != null).toList(),
        ));
  }

  _getUser() async {
    User user = await Auth().currentUser();
    setState(() {
      _user = user;
    });
  }
}
