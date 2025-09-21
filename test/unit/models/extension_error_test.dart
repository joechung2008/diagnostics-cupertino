import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('ExtensionError', () {
    test('fromJson should parse complete ExtensionError', () {
      // Arrange
      final json = {
        'errorMessage': 'Failed to load extension',
        'time': '2023-01-01T12:00:00Z',
      };

      // Act
      final error = ExtensionError.fromJson(json);

      // Assert
      expect(error.errorMessage, 'Failed to load extension');
      expect(error.time, '2023-01-01T12:00:00Z');
    });

    test('fromJson should handle null values', () {
      // Arrange
      final json = {'errorMessage': null, 'time': null};

      // Act
      final error = ExtensionError.fromJson(json);

      // Assert
      expect(error.errorMessage, 'Unknown error');
      expect(error.time, '');
    });

    test('fromJson should handle missing fields', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final error = ExtensionError.fromJson(json);

      // Assert
      expect(error.errorMessage, 'Unknown error');
      expect(error.time, '');
    });

    test('fromJson should convert non-string values to strings', () {
      // Arrange
      final json = {'errorMessage': 404, 'time': 1234567890};

      // Act
      final error = ExtensionError.fromJson(json);

      // Assert
      expect(error.errorMessage, '404');
      expect(error.time, '1234567890');
    });

    test('fromJson should handle complex error messages', () {
      // Arrange
      final json = {
        'errorMessage':
            'Network timeout after 30 seconds\nCaused by: Connection refused',
        'time': '2023-12-01T10:30:45.123Z',
      };

      // Act
      final error = ExtensionError.fromJson(json);

      // Assert
      expect(
        error.errorMessage,
        'Network timeout after 30 seconds\nCaused by: Connection refused',
      );
      expect(error.time, '2023-12-01T10:30:45.123Z');
    });
  });
}
