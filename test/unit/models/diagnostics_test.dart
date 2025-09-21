import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('Diagnostics', () {
    test('fromJson should parse valid JSON correctly', () {
      // Arrange
      final json = {
        'buildInfo': {'buildVersion': '1.2.3'},
        'extensions': {
          'extension1': {
            'extensionName': 'Test Extension 1',
            'version': '1.0.0',
          },
          'extension2': {
            'extensionName': 'Test Extension 2',
            'version': '2.0.0',
          },
        },
        'serverInfo': {
          'deploymentId': 'test-deployment-123',
          'extensionSync': {'totalSyncAllCount': 5},
          'hostname': 'test-server.example.com',
          'nodeVersions': 'v18.15.0',
          'serverId': 'server-456',
          'uptime': 86400,
        },
      };

      // Act
      final diagnostics = Diagnostics.fromJson(json);

      // Assert
      expect(diagnostics.buildInfo.buildVersion, '1.2.3');
      expect(diagnostics.extensions.length, 2);
      expect(diagnostics.extensions.containsKey('extension1'), isTrue);
      expect(diagnostics.extensions.containsKey('extension2'), isTrue);
      expect(
        diagnostics.extensions['extension1']!.info!.extensionName,
        'Test Extension 1',
      );
      expect(diagnostics.serverInfo.hostname, 'test-server.example.com');
      expect(diagnostics.serverInfo.uptime, 86400);
    });

    test('fromJson should handle empty extensions map', () {
      // Arrange
      final json = {
        'buildInfo': {'buildVersion': '1.0.0'},
        'extensions': {},
        'serverInfo': {
          'deploymentId': 'test-deployment',
          'extensionSync': {'totalSyncAllCount': 0},
          'hostname': 'test-server',
          'nodeVersions': 'v18.0.0',
          'serverId': 'test-server',
          'uptime': 3600,
        },
      };

      // Act
      final diagnostics = Diagnostics.fromJson(json);

      // Assert
      expect(diagnostics.extensions.length, 0);
      expect(diagnostics.buildInfo.buildVersion, '1.0.0');
    });

    test('fromJson should handle null values gracefully', () {
      // Arrange
      final json = {
        'buildInfo': {'buildVersion': null},
        'extensions': {
          'extension1': {'extensionName': null, 'version': null},
        },
        'serverInfo': {
          'deploymentId': null,
          'extensionSync': null,
          'hostname': null,
          'nodeVersions': null,
          'serverId': null,
          'uptime': null,
        },
      };

      // Act
      final diagnostics = Diagnostics.fromJson(json);

      // Assert
      expect(diagnostics.buildInfo.buildVersion, 'Unknown');
      expect(diagnostics.extensions.length, 1);
      expect(diagnostics.serverInfo.hostname, '');
      expect(diagnostics.serverInfo.uptime, 0);
    });
  });
}
