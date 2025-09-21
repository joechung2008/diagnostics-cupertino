import 'package:flutter/cupertino.dart';
import '../models.dart';
import '../widgets.dart';
import '../pages/dashboard_page.dart'; // For DashboardState

class DashboardBody extends StatelessWidget {
  final DashboardState state;
  final CupertinoTabController tabController;
  final ValueChanged<Environment?> onEnvironmentChanged;
  final ValueChanged<ExtensionInfo> onExtensionSelected;
  final ValueChanged<String> onShortcutPressed;

  const DashboardBody({
    super.key,
    required this.state,
    required this.tabController,
    required this.onEnvironmentChanged,
    required this.onExtensionSelected,
    required this.onShortcutPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    if (state.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }
    if (state.diagnostics == null) {
      return const Center(child: Text('No data'));
    }
    return Column(
      children: [
        DashboardToolbar(
          selectedEnvironment: state.selectedEnvironment,
          onEnvironmentChanged: onEnvironmentChanged,
          extensions: state.diagnostics!.extensions,
          onShortcutPressed: onShortcutPressed,
        ),
        // Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, _) => SizedBox(
                height: 60,
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: CupertinoTheme.of(
                    context,
                  ).barBackgroundColor,
                  thumbColor: CupertinoColors.systemGrey4,
                  groupValue: tabController.index,
                  onValueChanged: (value) {
                    if (value != null) {
                      tabController.index = value;
                    }
                  },
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Extensions', style: TextStyle(fontSize: 17)),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Build Info', style: TextStyle(fontSize: 17)),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Server Info',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  },
                ),
              ),
            ),
          ),
        ),
        // Tab content
        AnimatedBuilder(
          animation: tabController,
          builder: (context, _) => Expanded(
            child: IndexedStack(
              index: tabController.index,
              children: [
                ExtensionsTab(
                  extensions: state.diagnostics!.extensions,
                  selectedExtension: state.selectedExtension,
                  onExtensionSelected: onExtensionSelected,
                ),
                BuildInfoTab(buildInfo: state.diagnostics!.buildInfo),
                ServerInfoTab(serverInfo: state.diagnostics!.serverInfo),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
