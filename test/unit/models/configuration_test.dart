import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('Configuration', () {
    test('fromJson should parse configuration with string values', () {
      // Arrange
      final json = {
        'apiUrl': 'https://api.example.com',
        'timeout': '30',
        'enabled': 'true',
      };

      // Act
      final config = Configuration.fromJson(json);

      // Assert
      expect(config.config['apiUrl'], 'https://api.example.com');
      expect(config.config['timeout'], '30');
      expect(config.config['enabled'], 'true');
      expect(config.config.length, 3);
    });

    test('fromJson should convert non-string values to strings', () {
      // Arrange
      final json = {
        'port': 8080,
        'enabled': true,
        'timeout': 30.5,
        'nullValue': null,
      };

      // Act
      final config = Configuration.fromJson(json);

      // Assert
      expect(config.config['port'], '8080');
      expect(config.config['enabled'], 'true');
      expect(config.config['timeout'], '30.5');
      expect(config.config['nullValue'], '');
    });

    test('fromJson should handle empty configuration', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final config = Configuration.fromJson(json);

      // Assert
      expect(config.config.isEmpty, isTrue);
    });

    test('fromJson should handle nested objects by converting to string', () {
      // Arrange
      final json = {
        'nested': {'key': 'value'},
        'array': [1, 2, 3],
      };

      // Act
      final config = Configuration.fromJson(json);

      // Assert
      expect(config.config['nested'], '{key: value}');
      expect(config.config['array'], '[1, 2, 3]');
    });
  });
}
