import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/build_info_tab.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets('BuildInfoTab displays build version', (
    WidgetTester tester,
  ) async {
    final buildInfo = BuildInfo(buildVersion: '1.2.3');

    await tester.pumpWidget(
      CupertinoApp(home: BuildInfoTab(buildInfo: buildInfo)),
    );

    // Verify Table is present
    expect(find.byType(Table), findsOneWidget);

    // Verify column headers
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Value'), findsOneWidget);

    // Verify build version is displayed
    expect(find.text('Build Version'), findsOneWidget);
    expect(find.text('1.2.3'), findsOneWidget);
  });
}
