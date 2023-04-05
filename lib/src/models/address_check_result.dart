import 'address_check_options.dart';

class AddressCheckResult {
  AddressCheckResult(
    this.options, {
    required this.isSuccess,
  });

  final AddressCheckOptions options;

  final bool isSuccess;

  @override
  String toString() => 'AddressCheckResult($options, $isSuccess)';
}
