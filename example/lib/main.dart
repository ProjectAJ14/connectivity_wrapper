import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper_example/screens/menu_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'Connectivity Wrapper Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MenuScreen(),
        builder: (buildContext, widget) {
          return ConnectivityWidgetWrapper(
            disableInteraction: true,
            height: 80,
            child: widget!,
          );
        },
      ),
    );
  }
}
