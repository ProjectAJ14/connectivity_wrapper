import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/screens/scaffold_example_screen.dart';
import 'package:connectivity_wrapper_example/utils/strings.dart';
import 'package:connectivity_wrapper_example/utils/utils.dart';
import 'package:flutter/material.dart';

import 'custom_offline_widget_screen.dart';
import 'network_aware_widget_screen.dart';

class MenuScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Connectivity Wrapper Example"),
      ),
      body: ConnectivityScreenWrapper(
        disableInteraction: false,
        disableWidget: Container(
          color: Colors.red.withOpacity(0.3),
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(Strings.example1),
              onTap: () async {
                AppRoutes.push(context, const ScaffoldExampleScreen());
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(Strings.example2),
              onTap: () {
                AppRoutes.push(context, const CustomOfflineWidgetScreen());
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(Strings.example3),
              onTap: () {
                AppRoutes.push(context, const NetworkAwareWidgetScreen());
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(Strings.example4),
              onTap: () async {
                if (await ConnectivityWrapper.instance.isConnected) {
                  showSnackBar(
                    context,
                    title: "You Are Connected",
                    color: Colors.green,
                  );
                } else {
                  showSnackBar(
                    context,
                    title: "You Are Not Connected",
                  );
                }
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
