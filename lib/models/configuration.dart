class Configuration {
  final Map<String, String> config;

  Configuration({required this.config});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    final Map<String, String> config = {};
    json.forEach((key, value) {
      config[key] = value?.toString() ?? '';
    });
    return Configuration(config: config);
  }
}
