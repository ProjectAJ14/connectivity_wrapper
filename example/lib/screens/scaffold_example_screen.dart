import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class ScaffoldExampleScreen extends StatefulWidget {
  @override
  _ScaffoldExampleScreenState createState() => _ScaffoldExampleScreenState();
}

class _ScaffoldExampleScreenState extends State<ScaffoldExampleScreen> {
  AlignmentGeometry _alignment = Alignment.bottomCenter;

  bool _disableInteraction = false;
  bool _customDecoration = false;
  bool _customHeight = false;
  bool _customMessage = false;

  Decoration _decoration;
  double _height;
  String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.example1),
      ),
      body: ConnectivityWidgetWrapper(
        alignment: _alignment,
        disableInteraction: _disableInteraction,
        decoration: _decoration,
         height: _height,
        message: _message,
        messageStyle: _customMessage
            ? TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              )
            : null,
        child: ListView(
          children: <Widget>[
            CheckboxListTile(
              title: Text(Strings.customDecoration),
              value: _customDecoration,
              onChanged: (value) {
                setState(() {
                  _customDecoration = value;
                  if (_customDecoration) {
                    _decoration = BoxDecoration(
                      color: Colors.purple,
                      gradient: new LinearGradient(
                        colors: [Colors.red, Colors.cyan],
                      ),
                    );
                  } else {
                    _decoration = null;
                  }
                });
              },
            ),
            Divider(),
            Padding5(),
            CheckboxListTile(
              title: Text(Strings.customHeight),
              value: _customHeight,
              onChanged: (value) {
                setState(() {
                  _customHeight = value;
                  if (_customHeight) {
                    _height = 150.0;
                  } else {
                    _height = null;
                  }
                });
              },
            ),
            Divider(),
            Padding5(),
            CheckboxListTile(
              title: Text(Strings.customMessage),
              value: _customMessage,
              onChanged: (value) {
                setState(() {
                  _customMessage = value;
                  if (_customMessage) {
                    _message = Strings.offlineMessage;
                  } else {
                    _message = null;
                  }
                });
              },
            ),
            Divider(),
            Padding5(),
            ListTile(
              title: Text(Strings.customAlignment),
            ),
            Padding5(),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.topCenter;
                });
              },
            ),
            Divider(),
            Padding5(),
            IconButton(
              icon: Icon(Icons.center_focus_strong),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.center;
                });
              },
            ),
            Divider(),
            Padding5(),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.bottomCenter;
                });
              },
            ),
            Divider(),
            Padding5(),
            CheckboxListTile(
              title: Text(Strings.userInteraction),
              value: _disableInteraction,
              onChanged: (value) {
                setState(() {
                  _disableInteraction = value;
                });
              },
            ),
            Padding5(),
          ],
        ),
      ),
    );
  }
}
