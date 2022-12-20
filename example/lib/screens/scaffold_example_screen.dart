import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class ScaffoldExampleScreen extends StatefulWidget {
  const ScaffoldExampleScreen({Key key}) : super(key: key);

  @override
  State<ScaffoldExampleScreen> createState() => _ScaffoldExampleScreenState();
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
        title: const Text(Strings.example1),
      ),
      body: ConnectivityWidgetWrapper(
        alignment: _alignment,
        disableInteraction: _disableInteraction,
        decoration: _decoration,
        height: _height,
        message: _message,
        messageStyle: _customMessage
            ? const TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              )
            : null,
        child: ListView(
          children: <Widget>[
            CheckboxListTile(
              title: const Text(Strings.customDecoration),
              value: _customDecoration,
              onChanged: (value) {
                setState(() {
                  _customDecoration = value;
                  if (_customDecoration) {
                    _decoration = const BoxDecoration(
                      color: Colors.purple,
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.cyan,
                        ],
                      ),
                    );
                  } else {
                    _decoration = null;
                  }
                });
              },
            ),
            const Divider(),
            const PA5(),
            CheckboxListTile(
              title: const Text(Strings.customHeight),
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
            const Divider(),
            const PA5(),
            CheckboxListTile(
              title: const Text(Strings.customMessage),
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
            const Divider(),
            const PA5(),
            const ListTile(
              title: Text(Strings.customAlignment),
            ),
            const PA5(),
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.topCenter;
                });
              },
            ),
            const Divider(),
            const PA5(),
            IconButton(
              icon: const Icon(Icons.center_focus_strong),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.center;
                });
              },
            ),
            const Divider(),
            const PA5(),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.bottomCenter;
                });
              },
            ),
            const Divider(),
            const PA5(),
            CheckboxListTile(
              title: const Text(Strings.userInteraction),
              value: _disableInteraction,
              onChanged: (value) {
                setState(() {
                  _disableInteraction = value;
                });
              },
            ),
            const PA5(),
          ],
        ),
      ),
    );
  }
}
