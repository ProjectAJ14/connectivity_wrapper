import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/material.dart';

/// Connection Status Check Result
///
/// Connected: Device connected to network
/// Disconnected: Device not connected to any network
enum ConnectivityStatus { Connected, Disconnected }

/// [ConnectivityProvider] event ChangeNotifier class for ConnectivityStatus .
/// which extends [ChangeNotifier].

class ConnectivityProvider extends ChangeNotifier {

  /// [connectivityServiceRefreshTime] Defines the time interval
  /// to check the ConnectivityStatus again
  /// default[defaultRefreshTime] set to 2000 milliseconds
  final int connectivityServiceRefreshTime;

  StreamController<ConnectivityStatus> connectivityController = StreamController<ConnectivityStatus>();

  Stream<ConnectivityStatus> get connectivityStream => connectivityController.stream;

  ConnectivityProvider({this.connectivityServiceRefreshTime}) {
    connectivityController.add(ConnectivityStatus.Connected);
    Future.delayed(Duration(milliseconds:  defaultRefreshTime), () =>
        _updateConnectivityStatus());
  }

  _updateConnectivityStatus() async {
    if (await isConnected()) {
      try {
        final List<InternetAddress> result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          connectivityController.add(ConnectivityStatus.Connected);
        } else {
          connectivityController.add(ConnectivityStatus.Disconnected);
        }
      } on SocketException catch (_) {
        connectivityController.add(ConnectivityStatus.Disconnected);
      }
    } else {
      connectivityController.add(ConnectivityStatus.Disconnected);
    }

    Future.delayed(Duration(milliseconds: defaultRefreshTime), () => _updateConnectivityStatus());
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;
  }
}
