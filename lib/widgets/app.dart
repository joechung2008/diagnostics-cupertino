import 'package:flutter/cupertino.dart';
import '../pages.dart';

class DiagnosticsApp extends StatelessWidget {
  const DiagnosticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Azure Portal Extensions Dashboard',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
      home: DashboardPage(),
    );
  }
}
