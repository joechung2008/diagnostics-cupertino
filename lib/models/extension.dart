import 'extension_info.dart';
import 'extension_error.dart';

class Extension {
  final ExtensionInfo? info;
  final ExtensionError? error;

  Extension({this.info, this.error});

  bool get isInfo => info != null;
  bool get isError => error != null;

  factory Extension.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('extensionName')) {
      return Extension(info: ExtensionInfo.fromJson(json));
    } else if (json.containsKey('lastError') &&
        json['lastError'] is Map<String, dynamic>) {
      return Extension(error: ExtensionError.fromJson(json['lastError']));
    } else {
      throw FormatException('Invalid extension JSON: $json');
    }
  }
}
