import 'package:flutter/material.dart';

class AppRoutes {
  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

showSnackBar(
  BuildContext context, {
  required String title,
  Color? color,
  int milliseconds = 1000,
  TextStyle? style,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? Colors.red,
      duration: Duration(milliseconds: milliseconds),
      content: Container(
        constraints: const BoxConstraints(minHeight: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: style ??
                  const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    inherit: false,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
