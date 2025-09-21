import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/app.dart';
import 'package:diagnostics_cupertino/pages/dashboard_page.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const DiagnosticsApp());

    // Verify that the app bar title is displayed.
    expect(find.text('Azure Portal Extensions Dashboard'), findsOneWidget);

    // Verify that the DashboardPage is shown.
    expect(find.byType(DashboardPage), findsOneWidget);
  });
}
