import 'configuration.dart';
import 'stage_definition.dart';

class ExtensionInfo {
  final String extensionName;
  final Configuration? config;
  final StageDefinition? stageDefinition;

  ExtensionInfo({
    required this.extensionName,
    this.config,
    this.stageDefinition,
  });

  factory ExtensionInfo.fromJson(Map<String, dynamic> json) {
    return ExtensionInfo(
      extensionName: json['extensionName']?.toString() ?? '',
      config: json['config'] != null && json['config'] is Map<String, dynamic>
          ? Configuration.fromJson(json['config'])
          : null,
      stageDefinition:
          json['stageDefinition'] != null &&
              json['stageDefinition'] is Map<String, dynamic>
          ? StageDefinition.fromJson(json['stageDefinition'])
          : null,
    );
  }
}
