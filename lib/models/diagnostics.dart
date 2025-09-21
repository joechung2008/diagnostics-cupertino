import 'build_info.dart';
import 'extension.dart';
import 'server_info.dart';

class Diagnostics {
  final BuildInfo buildInfo;
  final Map<String, Extension> extensions;
  final ServerInfo serverInfo;

  Diagnostics({
    required this.buildInfo,
    required this.extensions,
    required this.serverInfo,
  });

  factory Diagnostics.fromJson(Map<String, dynamic> json) {
    final Map<String, Extension> exts = {};
    final extensionsJson = json['extensions'];
    if (extensionsJson is Map<String, dynamic>) {
      extensionsJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          exts[key] = Extension.fromJson(value);
        }
      });
    }

    return Diagnostics(
      buildInfo: BuildInfo.fromJson(json['buildInfo'] as Map<String, dynamic>),
      extensions: exts,
      serverInfo: ServerInfo.fromJson(
        json['serverInfo'] as Map<String, dynamic>,
      ),
    );
  }
}
