import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/configuration_widget.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets('ConfigurationWidget displays config data', (
    WidgetTester tester,
  ) async {
    final config = Configuration(config: {'key1': 'value1', 'key2': 'value2'});

    await tester.pumpWidget(
      CupertinoApp(home: ConfigurationWidget(config: config)),
    );

    // Verify the title
    expect(find.text('Configuration'), findsOneWidget);

    // Verify DataTable columns
    expect(find.text('Key'), findsOneWidget);
    expect(find.text('Value'), findsOneWidget);

    // Verify config entries
    expect(find.text('key1'), findsOneWidget);
    expect(find.text('value1'), findsOneWidget);
    expect(find.text('key2'), findsOneWidget);
    expect(find.text('value2'), findsOneWidget);

    // Verify Table is present
    expect(find.byType(Table), findsOneWidget);
  });
}
