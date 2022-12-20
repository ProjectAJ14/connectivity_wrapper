import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkAwareWidgetScreen extends StatelessWidget {
  const NetworkAwareWidgetScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.example3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          const TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          const PA5(),
          const TextField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          const PA5(),
          ConnectivityWidgetWrapper(
            stacked: false,
            offlineWidget: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Connecting",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    PA5(),
                    CupertinoActivityIndicator(radius: 8.0),
                  ],
                ),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
