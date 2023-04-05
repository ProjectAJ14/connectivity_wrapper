import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

import '../utils/strings.dart';

class ScaffoldExampleScreen extends StatefulWidget {
  const ScaffoldExampleScreen({super.key});

  @override
  State<ScaffoldExampleScreen> createState() => _ScaffoldExampleScreenState();
}

class _ScaffoldExampleScreenState extends State<ScaffoldExampleScreen> {
  AlignmentGeometry _alignment = Alignment.bottomCenter;

  bool _disableInteraction = false;
  bool _customDecoration = false;
  bool _customHeight = false;
  bool _customMessage = false;

  Decoration? _decoration;
  double? _height;
  String? _message;

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
                if (value == null) {
                  return;
                }
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
            const Spacer(),
            CheckboxListTile(
              title: const Text(Strings.customHeight),
              value: _customHeight,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
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
            const Spacer(),
            CheckboxListTile(
              title: const Text(Strings.customMessage),
              value: _customMessage,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
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
            const Spacer(),
            const ListTile(
              title: Text(Strings.customAlignment),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.topCenter;
                });
              },
            ),
            const Divider(),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.center_focus_strong),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.center;
                });
              },
            ),
            const Divider(),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () {
                setState(() {
                  _alignment = Alignment.bottomCenter;
                });
              },
            ),
            const Divider(),
            const Spacer(),
            CheckboxListTile(
              title: const Text(Strings.userInteraction),
              value: _disableInteraction,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _disableInteraction = value;
                });
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
