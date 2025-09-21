import 'package:flutter/cupertino.dart';
import '../models.dart';

class DashboardToolbar extends StatelessWidget {
  final Environment selectedEnvironment;
  final ValueChanged<Environment?> onEnvironmentChanged;
  final Map<String, Extension> extensions;
  final ValueChanged<String> onShortcutPressed;

  const DashboardToolbar({
    super.key,
    required this.selectedEnvironment,
    required this.onEnvironmentChanged,
    required this.extensions,
    required this.onShortcutPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!extensions.containsKey('websites') &&
        !extensions.containsKey('paasserverless')) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final row = Row(
          children: [
            // Environment selection
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showEnvironmentPicker(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CupertinoColors.systemGrey),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedEnvironment.displayName,
                      style: TextStyle(
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(CupertinoIcons.chevron_down, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            if (extensions.containsKey('paasserverless'))
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => onShortcutPressed('paasserverless'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CupertinoColors.systemGrey),
                  ),
                  child: Text(
                    'paasserverless',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            if (extensions.containsKey('websites'))
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => onShortcutPressed('websites'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CupertinoColors.systemGrey),
                  ),
                  child: Text('websites', overflow: TextOverflow.ellipsis),
                ),
              ),
          ],
        );

        return Container(
          color: CupertinoTheme.of(context).barBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: isSmall
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: row,
                )
              : row,
        );
      },
    );
  }

  void _showEnvironmentPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (index) {
            onEnvironmentChanged(Environment.values[index]);
          },
          children: Environment.values
              .map((env) => Center(child: Text(env.displayName)))
              .toList(),
        ),
      ),
    );
  }
}
