import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/dashboard_toolbar.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets(
    'DashboardToolbar renders with environment dropdown and shortcuts',
    (WidgetTester tester) async {
      // Mock extensions
      final extensions = <String, Extension>{
        'websites': Extension(),
        'paasserverless': Extension(),
      };

      Environment selectedEnvironment = Environment.public;
      String? shortcutPressed;

      await tester.pumpWidget(
        CupertinoApp(
          home: DashboardToolbar(
            selectedEnvironment: selectedEnvironment,
            onEnvironmentChanged: (env) {
              selectedEnvironment = env ?? Environment.public;
            },
            extensions: extensions,
            onShortcutPressed: (name) {
              shortcutPressed = name;
            },
          ),
        ),
      );

      // Verify environment selector button is present
      expect(find.byType(CupertinoButton), findsAtLeastNWidgets(1));
      expect(
        find.text('Public Cloud'),
        findsOneWidget,
      ); // Environment.public.displayName

      // Verify shortcut buttons
      expect(find.text('websites'), findsOneWidget);
      expect(find.text('paasserverless'), findsOneWidget);

      // Test shortcut button press
      await tester.tap(find.text('websites'));
      expect(shortcutPressed, 'websites');
    },
  );
}
