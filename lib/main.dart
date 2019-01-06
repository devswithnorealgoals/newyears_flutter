import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// todo: move login methods to its own class

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashPage(),
        '/home': (BuildContext context) => Home(),
        // '/splashscreen': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => Login()
      },
    );
  }
}

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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HOME TITLE'),
        ),
        body: Text("TEST")); //Login());
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                _formKey.currentState.save();
                _login(_email, _password);
              },
              child: Text("Login"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              child: Text("Create an account"),
            )
          ],
        ),
      ),
    );
  }

  Future<http.Response> _login(email, password) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Logging in..."),
    ));

    final response = await http
        .post(globals.login_url, body: {"email": email, "password": password});

    String _message = json.decode(response.body)['message'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_message),
    ));
    Navigator.pushReplacementNamed(context, '/home');
  }
}

class Signup extends StatefulWidget {
  @override
  SignupState createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIGNUP")),
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              onSaved: (val) {
                _firstName = val;
              },
            ),
            TextFormField(
                decoration: InputDecoration(labelText: "Last name"),
                onSaved: (val) {
                  _lastName = val;
                }),
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
                _signup(_firstName, _lastName, _email, _password);
              },
              child: Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> _signup(firstName, lastName, email, password) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Creating account..."),
    ));

    final response = await http.post(globals.signup_url, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    }).then((response) {
      String _message = json.decode(response.body)['message'];

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(_message),
      ));
    });
    return response;
  }
}
