import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert';
import 'user.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupState createState() {
    return SignupState();
  }
}

class SignupState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool userCreated = false;
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SIGNUP")),
        key: _scaffoldKey,
        body: this.userCreated ? _buildBackToLogin() : _buildSignupForm());
  }

  void _signup() async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Creating account..."),
    ));

    final response = await this.user.create();

    String _message = json.decode(response.body)['message'];
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_message)));
    if (response.statusCode == 201) setState(() => this.userCreated = true);
  }

  Widget _buildSignupForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            onSaved: (val) {
              this.user.firstName = val;
            },
          ),
          TextFormField(
              decoration: InputDecoration(labelText: "Last name"),
              onSaved: (val) {
                this.user.lastName = val;
              }),
          TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            onSaved: (val) {
              this.user.email = val;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            onSaved: (val) {
              this.user.password = val;
            },
          ),
          RaisedButton(
            onPressed: () {
              _formKey.currentState.save();
              _signup();
            },
            child: Text("Create account"),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToLogin() {
    return Center(child: Text("User created ! You can now login."));
  }
}
