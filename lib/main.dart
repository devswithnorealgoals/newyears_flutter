import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
        ),
        body: Login(),
      ),
    );
  }
}


class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
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
            onPressed: () {
              _formKey.currentState.save();
              login(_email, _password);
            },
            child: Text("Login"),
          )
        ],
      ),
    );
    ;
  }

  Future<http.Response> login(email, password) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Logging in..."),
    ));

    final response = await http.post(globals.login_url,
        body: {"email": email, "password": password}).then((response) {
      String _message = json.decode(response.body)['message'];

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(_message),
      ));
    });
    return response;
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    // TODO: implement createState
    return new LoginState();
  }
}
