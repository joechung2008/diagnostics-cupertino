import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/stage_definition_widget.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets('StageDefinitionWidget displays stage definition data', (
    WidgetTester tester,
  ) async {
    final stageDef = StageDefinition(
      stageDefinition: {
        'stage1': ['val1', 'val2'],
        'stage2': ['val3'],
      },
    );

    await tester.pumpWidget(
      CupertinoApp(home: StageDefinitionWidget(stageDefinition: stageDef)),
    );

    // Verify the title
    expect(find.text('Stage Definitions'), findsOneWidget);

    // Verify DataTable columns
    expect(find.text('Key'), findsOneWidget);
    expect(find.text('Value'), findsOneWidget);

    // Verify stage entries
    expect(find.text('stage1'), findsOneWidget);
    expect(find.text('val1, val2'), findsOneWidget);
    expect(find.text('stage2'), findsOneWidget);
    expect(find.text('val3'), findsOneWidget);

    // Verify Table is present
    expect(find.byType(Table), findsOneWidget);
  });
}
