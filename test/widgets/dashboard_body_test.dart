import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/dashboard_body.dart';
import 'package:diagnostics_cupertino/models.dart';
// No direct import of DashboardPage needed; DashboardState is exported from models.dart

void main() {
  testWidgets('DashboardBody displays tabs correctly', (
    WidgetTester tester,
  ) async {
    final diagnostics = Diagnostics(
      extensions: {},
      buildInfo: BuildInfo(buildVersion: '1.0.0'),
      serverInfo: ServerInfo(
        deploymentId: 'test',
        extensionSync: ExtensionSync(totalSyncAllCount: 0),
        hostname: 'test',
        nodeVersions: 'test',
        serverId: 'test',
        uptime: 0,
      ),
    );

    final tabController = CupertinoTabController();

    await tester.pumpWidget(
      CupertinoApp(
        home: DashboardBody(
          state: DashboardState(diagnostics: diagnostics),
          tabController: tabController,
          onEnvironmentChanged: (env) {},
          onExtensionSelected: (ext) {},
          onShortcutPressed: (name) {},
        ),
      ),
    );

    // Wait for the widget to build
    await tester.pumpAndSettle();

    // Verify segmented control is present
    expect(find.byType(CupertinoSlidingSegmentedControl<int>), findsOneWidget);

    // Verify tab texts
    expect(find.text('Extensions'), findsOneWidget);
    expect(find.text('Build Info'), findsOneWidget);
    expect(find.text('Server Info'), findsOneWidget);
  });
}
