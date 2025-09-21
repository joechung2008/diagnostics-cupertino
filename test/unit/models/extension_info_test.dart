import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('ExtensionInfo', () {
    test(
      'fromJson should parse complete ExtensionInfo with config and stageDefinition',
      () {
        // Arrange
        final json = {
          'extensionName': 'Test Extension',
          'config': {
            'setting1': 'value1',
            'setting2': 'value2',
            'setting3': 123,
          },
          'stageDefinition': {
            'stage1': ['step1', 'step2'],
            'stage2': ['step3'],
            'stage3': [],
          },
        };

        // Act
        final extensionInfo = ExtensionInfo.fromJson(json);

        // Assert
        expect(extensionInfo.extensionName, 'Test Extension');
        expect(extensionInfo.config, isNotNull);
        expect(extensionInfo.config!.config['setting1'], 'value1');
        expect(extensionInfo.config!.config['setting2'], 'value2');
        expect(
          extensionInfo.config!.config['setting3'],
          '123',
        ); // Number converted to string
        expect(extensionInfo.stageDefinition, isNotNull);
        expect(extensionInfo.stageDefinition!.stageDefinition['stage1'], [
          'step1',
          'step2',
        ]);
        expect(extensionInfo.stageDefinition!.stageDefinition['stage2'], [
          'step3',
        ]);
        expect(extensionInfo.stageDefinition!.stageDefinition['stage3'], []);
      },
    );

    test('fromJson should parse ExtensionInfo with only extensionName', () {
      // Arrange
      final json = {'extensionName': 'Simple Extension'};

      // Act
      final extensionInfo = ExtensionInfo.fromJson(json);

      // Assert
      expect(extensionInfo.extensionName, 'Simple Extension');
      expect(extensionInfo.config, isNull);
      expect(extensionInfo.stageDefinition, isNull);
    });

    test('fromJson should handle null extensionName', () {
      // Arrange
      final json = {'extensionName': null};

      // Act
      final extensionInfo = ExtensionInfo.fromJson(json);

      // Assert
      expect(extensionInfo.extensionName, '');
    });

    test('fromJson should handle invalid config JSON', () {
      // Arrange
      final json = {
        'extensionName': 'Test Extension',
        'config': 'invalid config', // Not a Map
        'stageDefinition': 'invalid stage', // Not a Map
      };

      // Act
      final extensionInfo = ExtensionInfo.fromJson(json);

      // Assert
      expect(extensionInfo.extensionName, 'Test Extension');
      expect(extensionInfo.config, isNull);
      expect(extensionInfo.stageDefinition, isNull);
    });

    test('fromJson should handle null config and stageDefinition', () {
      // Arrange
      final json = {
        'extensionName': 'Test Extension',
        'config': null,
        'stageDefinition': null,
      };

      // Act
      final extensionInfo = ExtensionInfo.fromJson(json);

      // Assert
      expect(extensionInfo.extensionName, 'Test Extension');
      expect(extensionInfo.config, isNull);
      expect(extensionInfo.stageDefinition, isNull);
    });
  });
}
