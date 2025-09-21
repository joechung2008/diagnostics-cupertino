class BuildInfo {
  final String buildVersion;

  BuildInfo({required this.buildVersion});

  factory BuildInfo.fromJson(Map<String, dynamic> json) {
    return BuildInfo(
      buildVersion: json['buildVersion']?.toString() ?? 'Unknown',
    );
  }
}
