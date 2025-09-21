import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('StageDefinition', () {
    test('fromJson should parse stage definition with valid lists', () {
      // Arrange
      final json = {
        'development': ['setup', 'build', 'test'],
        'staging': ['deploy', 'smoke-test'],
        'production': ['deploy', 'integration-test', 'monitor'],
      };

      // Act
      final stageDef = StageDefinition.fromJson(json);

      // Assert
      expect(stageDef.stageDefinition['development'], [
        'setup',
        'build',
        'test',
      ]);
      expect(stageDef.stageDefinition['staging'], ['deploy', 'smoke-test']);
      expect(stageDef.stageDefinition['production'], [
        'deploy',
        'integration-test',
        'monitor',
      ]);
      expect(stageDef.stageDefinition.length, 3);
    });

    test('fromJson should convert non-string list items to strings', () {
      // Arrange
      final json = {
        'numbers': [1, 2, 3],
        'mixed': ['string', 42, true, null],
      };

      // Act
      final stageDef = StageDefinition.fromJson(json);

      // Assert
      expect(stageDef.stageDefinition['numbers'], ['1', '2', '3']);
      expect(stageDef.stageDefinition['mixed'], [
        'string',
        '42',
        'true',
        'null',
      ]);
    });

    test('fromJson should handle empty lists', () {
      // Arrange
      final json = {
        'empty': [],
        'normal': ['step1', 'step2'],
      };

      // Act
      final stageDef = StageDefinition.fromJson(json);

      // Assert
      expect(stageDef.stageDefinition['empty'], []);
      expect(stageDef.stageDefinition['normal'], ['step1', 'step2']);
    });

    test('fromJson should handle non-list values by creating empty lists', () {
      // Arrange
      final json = {
        'string': 'not a list',
        'number': 42,
        'object': {'key': 'value'},
        'null': null,
      };

      // Act
      final stageDef = StageDefinition.fromJson(json);

      // Assert
      expect(stageDef.stageDefinition['string'], []);
      expect(stageDef.stageDefinition['number'], []);
      expect(stageDef.stageDefinition['object'], []);
      expect(stageDef.stageDefinition['null'], []);
    });

    test('fromJson should handle empty stage definition', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final stageDef = StageDefinition.fromJson(json);

      // Assert
      expect(stageDef.stageDefinition.isEmpty, isTrue);
    });
  });
}
