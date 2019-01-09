import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newyears_flutter/resolution.dart';
import 'package:newyears_flutter/auth.dart';
import 'package:newyears_flutter/user.dart';

class NewResolutionPage extends StatefulWidget {
  @override
  NewResolutionState createState() {
    return NewResolutionState();
  }
}

class NewResolutionState extends State<NewResolutionPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Resolution _resolution = Resolution();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NEW RESOLUTION')),
      key: _scaffoldKey,
      body: _buildResolutionForm(),
    );
  }

  Widget _buildResolutionForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            onSaved: (val) {
              this._resolution.name = val;
            },
          ),
          TextFormField(
              decoration: InputDecoration(labelText: "Year"),
              keyboardType: TextInputType.number,
              onSaved: (val) {
                this._resolution.year = int.tryParse(val) ?? 102930129301293;
              }),
          RaisedButton(
            onPressed: () {
              _formKey.currentState.save();
              _createResolution();
            },
            child: Text("Create resolution"),
          ),
        ],
      ),
    );
  }

  _createResolution() async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Creating resolution..."),
    ));

    User user = await Auth().currentUser();
    final response = await this._resolution.create(user.id);
    String message = json.decode(response.body)['message'];
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
    if (response.statusCode == 201) {
      Auth().setCurrentUser(User.fromJson(json.decode(response.body)['data']));
      Navigator.pop(context);
    }
  }
}
