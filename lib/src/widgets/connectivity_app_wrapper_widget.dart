import 'package:connectivity_wrapper/src/providers/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///[ConnectivityAppWrapper] is a StatelessWidget.

class ConnectivityAppWrapper extends StatelessWidget {
  /// [app] will accept MaterialApp or CupertinoApp must be non-null
  final Widget app;

  /// [connectivityServiceRefreshTime] Defines the time interval
  /// to check the ConnectivityStatus again
  /// default[defaultRefreshTime] set to 2000 milliseconds
  final int connectivityServiceRefreshTime;

  const ConnectivityAppWrapper(
      {Key key, @required this.app, this.connectivityServiceRefreshTime})
      : assert(app != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityProvider(
              connectivityServiceRefreshTime: connectivityServiceRefreshTime)
          .connectivityStream,
      child: app,
    );
  }
}
