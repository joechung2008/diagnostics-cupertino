class StageDefinition {
  final Map<String, List<String>> stageDefinition;

  StageDefinition({required this.stageDefinition});

  factory StageDefinition.fromJson(Map<String, dynamic> json) {
    final Map<String, List<String>> stageDef = {};
    json.forEach((key, value) {
      if (value is List) {
        stageDef[key] = List<String>.from(value.map((item) => item.toString()));
      } else {
        stageDef[key] = [];
      }
    });
    return StageDefinition(stageDefinition: stageDef);
  }
}
