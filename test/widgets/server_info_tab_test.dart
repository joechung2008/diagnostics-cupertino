import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/widgets/server_info_tab.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  testWidgets('ServerInfoTab displays server information', (
    WidgetTester tester,
  ) async {
    final serverInfo = ServerInfo(
      deploymentId: 'dep123',
      extensionSync: ExtensionSync(totalSyncAllCount: 42),
      hostname: 'server.example.com',
      nodeVersions: 'v14.0.0',
      serverId: 'srv456',
      uptime: 12345,
    );

    await tester.pumpWidget(
      CupertinoApp(home: ServerInfoTab(serverInfo: serverInfo)),
    );

    // Verify Table is present
    expect(find.byType(Table), findsOneWidget);

    // Verify some key information is displayed
    expect(find.text('Hostname'), findsOneWidget);
    expect(find.text('server.example.com'), findsOneWidget);
    expect(find.text('Server ID'), findsOneWidget);
    expect(find.text('srv456'), findsOneWidget);
    expect(find.text('Extension Sync | Total Sync All Count'), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
  });
}
