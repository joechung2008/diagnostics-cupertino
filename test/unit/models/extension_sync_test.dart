import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('ExtensionSync', () {
    test('fromJson should parse valid totalSyncAllCount', () {
      // Arrange
      final json = {'totalSyncAllCount': 42.7};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, 42.7); // Double preserved as num
    });

    test('fromJson should handle zero count', () {
      // Arrange
      final json = {'totalSyncAllCount': 0};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, 0);
    });

    test('fromJson should handle negative count', () {
      // Arrange
      final json = {'totalSyncAllCount': -5};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, -5);
    });

    test('fromJson should handle null totalSyncAllCount', () {
      // Arrange
      final json = {'totalSyncAllCount': null};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, 0);
    });

    test('fromJson should handle missing totalSyncAllCount field', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, 0);
    });

    test('fromJson should handle non-integer values', () {
      // Arrange
      final json = {'totalSyncAllCount': '42'};

      // Act
      final sync = ExtensionSync.fromJson(json);

      // Assert
      expect(sync.totalSyncAllCount, 0); // Non-integer defaults to 0
    });

    test('fromJson should handle various numeric values', () {
      // Test different numeric types
      final testCases = [
        {'value': 0, 'expected': 0},
        {'value': 42, 'expected': 42},
        {'value': 42.0, 'expected': 42.0}, // Double with .0
        {'value': 42.7, 'expected': 42.7}, // Double with fractional part
        {'value': -10, 'expected': -10}, // Negative int
        {'value': -10.9, 'expected': -10.9}, // Negative double
      ];

      for (final testCase in testCases) {
        final json = {'totalSyncAllCount': testCase['value']};
        final sync = ExtensionSync.fromJson(json);
        expect(
          sync.totalSyncAllCount,
          testCase['expected'],
          reason: 'Failed for value: ${testCase['value']}',
        );
      }
    });
  });
}
