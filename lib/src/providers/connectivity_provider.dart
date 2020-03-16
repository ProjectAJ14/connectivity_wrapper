import 'dart:async';

import 'package:connectivity/connectivity.dart';
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
    _updateConnectivityStatus();
  }

  _updateConnectivityStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    connectivityController.add(
      connectivityResult == ConnectivityResult.none
          ? ConnectivityStatus.DISCONNECTED
          : ConnectivityStatus.CONNECTED,
    );
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityController.add(
        result == ConnectivityResult.none
            ? ConnectivityStatus.DISCONNECTED
            : ConnectivityStatus.CONNECTED,
      );
    });

    // ConnectivityService()
    //     .onStatusChange
    //     .listen((ConnectivityStatus connectivityStatus) {
    //   connectivityController.add(connectivityStatus);
    // });
  }
}
