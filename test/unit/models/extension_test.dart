import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('Extension Model', () {
    test('should create Extension with info from JSON', () {
      final json = {
        'extensionName': 'testExtension',
        'config': {'key': 'value'},
        'stageDefinition': {
          'stage': ['definition'],
        },
      };

      final extension = Extension.fromJson(json);

      expect(extension.isInfo, true);
      expect(extension.isError, false);
      expect(extension.info?.extensionName, 'testExtension');
      expect(extension.error, null);
    });

    test('should create Extension with error from JSON', () {
      final json = {
        'lastError': {
          'errorMessage': 'Test error message',
          'time': '2023-01-01T00:00:00Z',
        },
      };

      final extension = Extension.fromJson(json);

      expect(extension.isInfo, false);
      expect(extension.isError, true);
      expect(extension.error?.errorMessage, 'Test error message');
      expect(extension.error?.time, '2023-01-01T00:00:00Z');
      expect(extension.info, null);
    });

    test('should throw FormatException for invalid JSON', () {
      final json = {'invalidField': 'value'};

      expect(
        () => Extension.fromJson(json),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('Invalid extension JSON'),
          ),
        ),
      );
    });

    test('should handle empty Extension', () {
      final extension = Extension();

      expect(extension.isInfo, false);
      expect(extension.isError, false);
      expect(extension.info, null);
      expect(extension.error, null);
    });
  });
}
