import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/pages/dashboard_page.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets('DashboardPage renders correctly', (WidgetTester tester) async {
    // Build the DashboardPage.
    await tester.pumpWidget(CupertinoApp(home: const DashboardPage()));

    // Wait for any async operations.
    await tester.pumpAndSettle();

    // Verify that the app bar title is displayed.
    expect(find.text('Azure Portal Extensions Dashboard'), findsOneWidget);

    // Note: Tabs require data to be loaded; for now, test basic rendering.
    // In a full test, mock DiagnosticsService to provide data.
  });

  testWidgets('DashboardPage state management', (WidgetTester tester) async {
    await tester.pumpWidget(CupertinoApp(home: const DashboardPage()));

    // Test that the widget can be created and disposed without errors
    await tester.pumpAndSettle();

    // Verify the widget builds successfully
    expect(find.byType(DashboardPage), findsOneWidget);
  });

  testWidgets('DashboardState copyWith method coverage', (
    WidgetTester tester,
  ) async {
    // Test the DashboardState copyWith method directly
    const initialState = DashboardState();

    // Test copyWith with different parameters to exercise all code paths
    var newState = initialState.copyWith(
      selectedEnvironment: Environment.fairfax,
    );
    expect(newState.selectedEnvironment, Environment.fairfax);

    newState = initialState.copyWith(isLoading: true);
    expect(newState.isLoading, true);

    newState = initialState.copyWith(error: 'Test error');
    expect(newState.error, 'Test error');

    // Test copyWith with null values (should keep original values)
    newState = initialState.copyWith();
    expect(newState.selectedEnvironment, initialState.selectedEnvironment);
    expect(newState.isLoading, initialState.isLoading);
    expect(newState.error, initialState.error);
    expect(newState.diagnostics, initialState.diagnostics);
  });

  testWidgets('DashboardPage lifecycle methods', (WidgetTester tester) async {
    await tester.pumpWidget(CupertinoApp(home: const DashboardPage()));

    // Test initState by pumping the widget
    await tester.pump();

    // Test that the widget initializes properly
    expect(find.byType(DashboardPage), findsOneWidget);

    // Test dispose by removing the widget
    await tester.pumpWidget(Container());
    await tester.pump();

    // Widget should be disposed without errors
    expect(find.byType(DashboardPage), findsNothing);
  });
}
