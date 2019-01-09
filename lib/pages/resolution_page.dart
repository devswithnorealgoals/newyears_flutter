import 'package:flutter/material.dart';
import 'package:newyears_flutter/resolution.dart';

class ResolutionPage extends StatefulWidget {
  Resolution _resolution;
  ResolutionPage(this._resolution);
  @override
  ResolutionState createState() {
    return ResolutionState(_resolution);
  }
}

class ResolutionState extends State<ResolutionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Resolution _resolution;

  ResolutionState(this._resolution);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RESOLUTION')),
      key: _scaffoldKey,
      body: Text(_resolution.name),
    );
  }
}
