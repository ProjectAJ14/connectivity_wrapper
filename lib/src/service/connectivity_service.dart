import 'dart:async';
import 'dart:io';

import 'package:connectivity_wrapper/src/utils/constants.dart';

class ConnectivityService {
  static final List<AddressCheckOptions> defaultAddresses = List.unmodifiable([
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

  List<AddressCheckOptions> addresses = defaultAddresses;

  factory ConnectivityService() => _instance;

  ConnectivityService._() {
    _statusController.onListen = () {
      _maybeEmitStatusUpdate();
    };
    _statusController.onCancel = () {
      _timerHandle?.cancel();
      _lastStatus = null;
    };
  }

  static final ConnectivityService _instance = ConnectivityService._();

  Future<AddressCheckResult> isHostReachable(
    AddressCheckOptions options,
  ) async {
    Socket sock;
    try {
      sock = await Socket.connect(
        options.address,
        options.port,
        timeout: options.timeout,
      );
      sock?.destroy();
      return AddressCheckResult(options, true);
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(options, false);
    }
  }

  List<AddressCheckResult> get lastTryResults => _lastTryResults;
  List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];

  Future<bool> get hasConnection async {
    List<Future<AddressCheckResult>> requests = [];

    for (var addressOptions in addresses) {
      requests.add(isHostReachable(addressOptions));
    }
    _lastTryResults = List.unmodifiable(await Future.wait(requests));

    return _lastTryResults.map((result) => result.isSuccess).contains(true);
  }

  Future<ConnectivityStatus> get connectionStatus async {
    return await hasConnection ? ConnectivityStatus.CONNECTED : ConnectivityStatus.DISCONNECTED;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  _maybeEmitStatusUpdate([Timer timer]) async {
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

  ConnectivityStatus _lastStatus;
  Timer _timerHandle;

  StreamController<ConnectivityStatus> _statusController = StreamController.broadcast();

  Stream<ConnectivityStatus> get onStatusChange => _statusController.stream;

  bool get hasListeners => _statusController.hasListener;

  bool get isActivelyChecking => _statusController.hasListener;
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
