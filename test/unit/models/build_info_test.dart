import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('BuildInfo', () {
    test('fromJson should parse buildVersion correctly', () {
      // Arrange
      final json = {'buildVersion': '1.2.3'};

      // Act
      final buildInfo = BuildInfo.fromJson(json);

      // Assert
      expect(buildInfo.buildVersion, '1.2.3');
    });

    test('fromJson should handle null buildVersion', () {
      // Arrange
      final json = {'buildVersion': null};

      // Act
      final buildInfo = BuildInfo.fromJson(json);

      // Assert
      expect(buildInfo.buildVersion, 'Unknown');
    });

    test('fromJson should handle missing buildVersion field', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final buildInfo = BuildInfo.fromJson(json);

      // Assert
      expect(buildInfo.buildVersion, 'Unknown');
    });

    test('fromJson should handle non-string buildVersion', () {
      // Arrange
      final json = {'buildVersion': 123};

      // Act
      final buildInfo = BuildInfo.fromJson(json);

      // Assert
      expect(buildInfo.buildVersion, '123');
    });
  });
}
