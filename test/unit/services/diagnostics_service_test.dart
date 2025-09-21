import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';
import 'package:diagnostics_cupertino/services/diagnostics_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Note: For proper testing of HTTP calls, the DiagnosticsService should be refactored
// to accept an http.Client parameter. This test demonstrates the expected behavior.

@GenerateMocks([http.Client])
import 'diagnostics_service_test.mocks.dart';

void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  group('Environment URLs', () {
    test('should provide correct URLs for different environments', () {
      expect(Environment.public.url, contains('portal.azure.net'));
      expect(Environment.fairfax.url, contains('usgovcloudapi.net'));
      expect(Environment.mooncake.url, contains('chinacloudapi.cn'));
    });

    test('URLs should be valid HTTPS endpoints', () {
      for (var env in Environment.values) {
        expect(env.url, startsWith('https://'));
        expect(env.url, endsWith('/api/diagnostics'));
      }
    });
  });

  group('Diagnostics Model Integration', () {
    test('should create valid Diagnostics from JSON structure', () {
      // This test verifies that our model classes work together correctly
      final json = {
        'buildInfo': {'buildVersion': '1.0.0'},
        'extensions': {},
        'serverInfo': {
          'deploymentId': 'test',
          'extensionSync': {'totalSyncAllCount': 0},
          'hostname': 'test',
          'nodeVersions': 'v18',
          'serverId': 'test',
          'uptime': 0,
        },
      };

      final diagnostics = Diagnostics.fromJson(json);

      expect(diagnostics.buildInfo.buildVersion, '1.0.0');
      expect(diagnostics.extensions, isA<Map<String, Extension>>());
      expect(diagnostics.serverInfo.hostname, 'test');
    });
  });

  group('DiagnosticsService HTTP Integration', () {
    late DiagnosticsService service;

    setUp(() {
      service = DiagnosticsService(mockClient);
    });

    test('fetchDiagnostics should handle successful response', () async {
      final testJson = {
        'buildInfo': {'buildVersion': '1.0.0'},
        'extensions': {},
        'serverInfo': {
          'deploymentId': 'test',
          'extensionSync': {'totalSyncAllCount': 0},
          'hostname': 'test',
          'nodeVersions': 'v18',
          'serverId': 'test',
          'uptime': 0,
        },
      };

      // Mock the HTTP response
      when(
        mockClient.get(Uri.parse(Environment.public.url)),
      ).thenAnswer((_) async => http.Response(jsonEncode(testJson), 200));

      final diagnostics = await service.fetchDiagnostics(Environment.public);

      expect(diagnostics.buildInfo.buildVersion, '1.0.0');
      expect(diagnostics.serverInfo.hostname, 'test');
    });

    test('fetchDiagnostics should handle HTTP error responses', () async {
      when(
        mockClient.get(Uri.parse(Environment.public.url)),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () => service.fetchDiagnostics(Environment.public),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to fetch diagnostics: 404'),
          ),
        ),
      );
    });

    test('fetchDiagnostics should handle JSON parsing errors', () async {
      when(
        mockClient.get(Uri.parse(Environment.public.url)),
      ).thenAnswer((_) async => http.Response('invalid json', 200));

      expect(
        () => service.fetchDiagnostics(Environment.public),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to parse diagnostics response'),
          ),
        ),
      );
    });
  });
}
