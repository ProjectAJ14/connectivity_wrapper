import 'dart:async';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

/// [ConnectivityProvider] event ChangeNotifier class for ConnectivityStatus .
/// which extends [ChangeNotifier].
///
class ConnectivityProvider extends ChangeNotifier {
  StreamController<ConnectivityStatus> connectivityController =
      StreamController<ConnectivityStatus>();

  Stream<ConnectivityStatus> get connectivityStream =>
      connectivityController.stream;

  ConnectivityProvider() {
    connectivityController.add(ConnectivityStatus.CONNECTED);
    _updateConnectivityStatus();
  }

  _updateConnectivityStatus() async {
    ConnectivityWrapper.instance.onStatusChange
        .listen((ConnectivityStatus connectivityStatus) {
      connectivityController.add(connectivityStatus);
    });
  }
}
