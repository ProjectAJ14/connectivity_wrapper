import 'package:connectivity_wrapper_example/screens/scaffold_example_screen.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/utils.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectivity Wrapper Example"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(Strings.example1),
            onTap: () {
              AppRoutes.push(context, ScaffoldExampleScreen());
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
