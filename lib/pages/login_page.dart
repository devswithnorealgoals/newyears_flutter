import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newyears_flutter/app_state_container.dart';
import 'package:newyears_flutter/globals.dart' as globals;
import 'package:newyears_flutter/models/auth.dart';
import 'dart:convert';

import 'package:newyears_flutter/pages/signup_page.dart';
// todo: move login methods to its own class

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final container = AppStateContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              onSaved: (val) {
                _email = val;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              onSaved: (val) {
                _password = val;
              },
            ),
            RaisedButton(
              onPressed: () async {
                _formKey.currentState.save();
                await _login(container, _email, _password);
              },
              child: Text("Login"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text("Create an account"),
            )
          ],
        ),
      ),
    );
  }

  Future _login(container, email, password) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Logging in..."),
    ));
    final response = await http
        .post(globals.login_url, body: {"email": email, "password": password});

    String _message = json.decode(response.body)['message'];
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_message),
    ));

    if (response.statusCode == 200) {
      String token = json.decode(response.body)['data']['token'];
      Auth().login(token);
      container.login();
    }
  }
}