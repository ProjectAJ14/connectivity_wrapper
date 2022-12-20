/// A pure Dart utility library that checks for an internet connection
/// by opening a socket to a list of specified addresses, each with individual
/// port and timeout. Defaults are provided for convenience.
///
/// All addresses are pinged simultaneously.
/// On successful result (socket connection to address/port succeeds)
/// a true boolean is pushed to a list, on failure
/// (usually on timeout, default 10 sec)
/// a false boolean is pushed to the same list.
///
library connectivity_wrapper;

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:flutter/foundation.dart';

export 'package:connectivity_wrapper/src/widgets/connectivity_app_wrapper_widget.dart';
export 'package:connectivity_wrapper/src/widgets/connectivity_screen_wrapper.dart';
export 'package:connectivity_wrapper/src/widgets/connectivity_widget_wrapper.dart';

/// Connection Status Check Result
///
/// [CONNECTED]: Device connected to network
/// [DISCONNECTED]: Device not connected to any network
///
enum ConnectivityStatus { CONNECTED, DISCONNECTED }

class ConnectivityWrapper {
  static List<AddressCheckOptions> get _defaultAddresses => (kIsWeb)
      ? []
      : List.unmodifiable([
          AddressCheckOptions(
            InternetAddress('1.1.1.1'),
            port: DEFAULT_PORT,
            timeout: DEFAULT_TIMEOUT,
          ),
          AddressCheckOptions(
            InternetAddress('8.8.4.4'),
            port: DEFAULT_PORT,
            timeout: DEFAULT_TIMEOUT,
          ),
          AddressCheckOptions(
            InternetAddress('208.67.222.222'),
            port: DEFAULT_PORT,
            timeout: DEFAULT_TIMEOUT,
          ),
        ]);

  List<AddressCheckOptions> addresses = _defaultAddresses;

  ConnectivityWrapper._() {
    _statusController.onListen = () {
      _maybeEmitStatusUpdate();
    };
    _statusController.onCancel = () {
      _timerHandle?.cancel();
      _lastStatus = null;
    };
  }

  static final ConnectivityWrapper instance = ConnectivityWrapper._();

  Future<AddressCheckResult> isHostReachable(
    AddressCheckOptions options,
  ) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        options.address,
        options.port,
        timeout: options.timeout,
      );
      sock.destroy();
      return AddressCheckResult(options, true);
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(options, false);
    }
  }

  List<AddressCheckResult> get lastTryResults => _lastTryResults;
  List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];

  Future<bool> get isConnected async {
    bool connected = await _checkWebConnection();
    if (kIsWeb) return connected;
    if (!connected) return connected;

    List<Future<AddressCheckResult>> requests = [];

    for (var addressOptions in addresses) {
      requests.add(isHostReachable(addressOptions));
    }
    _lastTryResults = List.unmodifiable(await Future.wait(requests));

    return _lastTryResults.map((result) => result.isSuccess).contains(true);
  }

  Future<ConnectivityStatus> get connectionStatus async {
    return await isConnected
        ? ConnectivityStatus.CONNECTED
        : ConnectivityStatus.DISCONNECTED;
  }

  ///
  Future<bool> _checkWebConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  _maybeEmitStatusUpdate([Timer? timer]) async {
    _timerHandle?.cancel();
    timer?.cancel();

    var currentStatus = await connectionStatus;

    if (_lastStatus != currentStatus && _statusController.hasListener) {
      _statusController.add(currentStatus);
    }

    if (!_statusController.hasListener) return;
    _timerHandle = Timer(checkInterval, _maybeEmitStatusUpdate);

    _lastStatus = currentStatus;
  }

  ConnectivityStatus? _lastStatus;
  Timer? _timerHandle;

  StreamController<ConnectivityStatus> _statusController =
      StreamController.broadcast();

  Stream<ConnectivityStatus> get onStatusChange => _statusController.stream;

  bool get hasListeners => _statusController.hasListener;

  bool get isActivelyChecking => _statusController.hasListener;

  ConnectivityStatus? get lastStatus => _lastStatus;
}

class AddressCheckOptions {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  AddressCheckOptions(
    this.address, {
    this.port = DEFAULT_PORT,
    this.timeout = DEFAULT_TIMEOUT,
  });

  @override
  String toString() => "AddressCheckOptions($address, $port, $timeout)";
}

class AddressCheckResult {
  final AddressCheckOptions options;
  final bool isSuccess;

  AddressCheckResult(
    this.options,
    this.isSuccess,
  );

  @override
  String toString() => "AddressCheckResult($options, $isSuccess)";
}
