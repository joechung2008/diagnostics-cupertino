import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models.dart';

class DiagnosticsService {
  final http.Client _client;

  DiagnosticsService([http.Client? client]) : _client = client ?? http.Client();

  Future<Diagnostics> fetchDiagnostics(Environment environment) async {
    return await _fetchFromApi(environment.url);
  }

  Future<Diagnostics> _fetchFromApi(String url) async {
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch diagnostics: ${response.statusCode}');
    }

    try {
      final jsonData = json.decode(response.body);
      return Diagnostics.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to parse diagnostics response: $e');
    }
  }
}
