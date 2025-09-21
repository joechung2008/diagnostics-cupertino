import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('ServerInfo', () {
    test('fromJson should parse complete ServerInfo with all fields', () {
      // Arrange
      final json = {
        'deploymentId': 'prod-deployment-123',
        'extensionSync': {'totalSyncAllCount': 15},
        'hostname': 'web-server-01.example.com',
        'nodeVersions': 'v18.15.0, v16.19.1',
        'serverId': 'server-456',
        'uptime': 86400,
      };

      // Act
      final serverInfo = ServerInfo.fromJson(json);

      // Assert
      expect(serverInfo.deploymentId, 'prod-deployment-123');
      expect(serverInfo.extensionSync.totalSyncAllCount, 15);
      expect(serverInfo.hostname, 'web-server-01.example.com');
      expect(serverInfo.nodeVersions, 'v18.15.0, v16.19.1');
      expect(serverInfo.serverId, 'server-456');
      expect(serverInfo.uptime, 86400);
    });

    test('fromJson should handle decimal uptime values', () {
      // Arrange
      final json = {
        'uptime': 86400.5, // Double instead of int
        'hostname': 'test-server',
      };

      // Act
      final serverInfo = ServerInfo.fromJson(json);

      // Assert
      expect(serverInfo.uptime, 86400.5); // Double preserved as num
      expect(serverInfo.hostname, 'test-server');
    });

    test('fromJson should handle various numeric uptime values', () {
      // Test different numeric types
      final testCases = [
        {'uptime': 0, 'expected': 0},
        {'uptime': 123, 'expected': 123},
        {'uptime': 86400.0, 'expected': 86400.0}, // Double with .0
        {'uptime': 86400.7, 'expected': 86400.7}, // Double with fractional part
        {'uptime': -3600, 'expected': -3600}, // Negative int
        {'uptime': -3600.9, 'expected': -3600.9}, // Negative double
      ];

      for (final testCase in testCases) {
        final json = {'uptime': testCase['uptime']};
        final serverInfo = ServerInfo.fromJson(json);
        expect(
          serverInfo.uptime,
          testCase['expected'],
          reason: 'Failed for uptime: ${testCase['uptime']}',
        );
      }
    });
  });
}
