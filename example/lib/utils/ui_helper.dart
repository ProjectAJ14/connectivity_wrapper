import 'package:flutter/material.dart';

class Spacer extends StatelessWidget {
  final double? size;

  const Spacer({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(size ?? 5.0));
  }
}
