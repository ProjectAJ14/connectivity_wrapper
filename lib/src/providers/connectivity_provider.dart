import 'dart:async';

import 'package:connectivity_wrapper/src/service/connectivity_service.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/material.dart';

/// [ConnectivityProvider] event ChangeNotifier class for ConnectivityStatus .
/// which extends [ChangeNotifier].

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
    ConnectivityService()
        .onStatusChange
        .listen((ConnectivityStatus connectivityStatus) {
      connectivityController.add(connectivityStatus);
    });
  }
}
