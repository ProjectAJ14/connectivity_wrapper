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

import 'src/models/address_check_options.dart';
import 'src/models/address_check_result.dart';

export 'package:connectivity_wrapper/src/widgets/connectivity_app_wrapper_widget.dart';
export 'package:connectivity_wrapper/src/widgets/connectivity_screen_wrapper.dart';
export 'package:connectivity_wrapper/src/widgets/connectivity_widget_wrapper.dart';

export 'src/models/address_check_options.dart';
export 'src/models/address_check_result.dart';

/// Connection Status Check Result
///
/// [CONNECTED]: Device connected to network
/// [DISCONNECTED]: Device not connected to any network
///
enum ConnectivityStatus { CONNECTED, DISCONNECTED }

class ConnectivityWrapper {
  static List<AddressCheckOptions> get _defaultAddresses => (kIsWeb)
      ? []
      : List<AddressCheckOptions>.unmodifiable(
          <AddressCheckOptions>[
            AddressCheckOptions(
              address: InternetAddress(
                '1.1.1.1',
                type: InternetAddressType.IPv4,
              ),
            ),
            AddressCheckOptions(
              address: InternetAddress(
                '2606:4700:4700::1111',
                type: InternetAddressType.IPv6,
              ),
            ),
            AddressCheckOptions(
              address: InternetAddress(
                '8.8.4.4',
                type: InternetAddressType.IPv4,
              ),
            ),
            AddressCheckOptions(
              address: InternetAddress(
                '2001:4860:4860::8888',
                type: InternetAddressType.IPv6,
              ),
            ),
            AddressCheckOptions(
              address: InternetAddress(
                '208.67.222.222',
                type: InternetAddressType.IPv4,
              ),
            ),
            AddressCheckOptions(
              address: InternetAddress(
                '2620:0:ccc::2',
                type: InternetAddressType.IPv6,
              ),
            ),
          ],
        );

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
        options.address ?? options.hostname,
        options.port,
        timeout: options.timeout,
      )
        ..destroy();
      return AddressCheckResult(
        options,
        isSuccess: true,
      );
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(
        options,
        isSuccess: false,
      );
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

  ConnectivityStatus? _lastStatus;

  Timer? _timerHandle;

  final StreamController<ConnectivityStatus> _statusController =
      StreamController.broadcast();

  Stream<ConnectivityStatus> get onStatusChange => _statusController.stream;

  bool get hasListeners => _statusController.hasListener;

  bool get isActivelyChecking => _statusController.hasListener;

  ConnectivityStatus? get lastStatus => _lastStatus;

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
}
