import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkAwareWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.example3),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          Padding5(),
          TextField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          Padding5(),
          ConnectivityWidgetWrapper(
            stacked: false,
            offlineWidget: RaisedButton(
              onPressed: null,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Connecting",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Padding5(),
                    CupertinoActivityIndicator(radius: 8.0),
                  ],
                ),
              ),
            ),
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
