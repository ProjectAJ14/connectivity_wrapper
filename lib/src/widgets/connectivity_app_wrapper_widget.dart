import 'package:connectivity_wrapper/src/providers/connectivity_provider.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///[ConnectivityAppWrapper] is a StatelessWidget.

class ConnectivityAppWrapper extends StatelessWidget {
  /// [app] will accept MaterialApp or CupertinoApp must be non-null
  /// [type] will accept ConnectivityStatusType enum
  final Widget app;
  final ConnectivityStatusType type;

  const ConnectivityAppWrapper({
    Key key,
    @required this.app,
    this.type = ConnectivityStatusType.Ping,
  })  : assert(app != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityProvider(
        type: type,
      ).connectivityStream,
      child: app,
    );
  }
}
