import 'dart:io';

import '../utils/constants.dart';

/// Address Check Options
///
class AddressCheckOptions {
  /// [AddressCheckOptions] Constructor
  AddressCheckOptions({
    this.address,
    this.hostname,
    this.port = DEFAULT_PORT,
    this.timeout = DEFAULT_TIMEOUT,
  }) : assert(
          (address != null || hostname != null) &&
              ((address != null) != (hostname != null)),
          'Either address or hostname must be provided, but not both.',
        );

  final InternetAddress? address;

  final String? hostname;

  /// Port
  final int port;

  /// Timeout Duration
  final Duration timeout;

  @override
  String toString() => 'AddressCheckOptions($address, $port, $timeout)';
}
