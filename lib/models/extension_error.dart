class ExtensionError {
  final String errorMessage;
  final String time;

  ExtensionError({required this.errorMessage, required this.time});

  factory ExtensionError.fromJson(Map<String, dynamic> json) {
    return ExtensionError(
      errorMessage: json['errorMessage']?.toString() ?? 'Unknown error',
      time: json['time']?.toString() ?? '',
    );
  }
}
