import 'package:flutter/cupertino.dart';
import '../models.dart';
import 'configuration_widget.dart';
import 'stage_definition_widget.dart';

class ExtensionsTab extends StatefulWidget {
  final Map<String, Extension> extensions;
  final ExtensionInfo? selectedExtension;
  final ValueChanged<ExtensionInfo> onExtensionSelected;

  const ExtensionsTab({
    super.key,
    required this.extensions,
    required this.selectedExtension,
    required this.onExtensionSelected,
  });

  @override
  State<ExtensionsTab> createState() => _ExtensionsTabState();
}

class _ExtensionsTabState extends State<ExtensionsTab> {
  bool _showList = true;

  @override
  void didUpdateWidget(covariant ExtensionsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedExtension != null &&
        widget.selectedExtension != oldWidget.selectedExtension) {
      // When a new extension is selected, ensure details are shown on small screens
      final isSmall = MediaQuery.of(context).size.width < 600;
      if (isSmall) {
        _showList = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;

        final listWidget = SizedBox(
          width: isSmall ? double.infinity : 300,
          height: isSmall ? double.infinity : null,
          child: ListView(
            children:
                (widget.extensions.entries
                        .where((entry) => entry.value.isInfo)
                        .toList()
                      ..sort(
                        (a, b) => a.value.info!.extensionName.compareTo(
                          b.value.info!.extensionName,
                        ),
                      ))
                    .map(
                      (entry) => CupertinoListTile(
                        title: Text(
                          entry.value.info!.extensionName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () =>
                            widget.onExtensionSelected(entry.value.info!),
                      ),
                    )
                    .toList(),
          ),
        );

        final detailsWidget = SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.selectedExtension != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedExtension!.extensionName,
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.navTitleTextStyle,
                      ),
                      const SizedBox(height: 16),
                      if (widget.selectedExtension!.config != null)
                        ConfigurationWidget(
                          config: widget.selectedExtension!.config!,
                        ),
                      if (widget.selectedExtension!.stageDefinition != null)
                        StageDefinitionWidget(
                          stageDefinition:
                              widget.selectedExtension!.stageDefinition!,
                        ),
                    ],
                  ),
                )
              : const Center(child: Text('Select an extension')),
        );

        if (isSmall) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Semantics(
                  label: _showList ? 'Show Details' : 'Show List',
                  child: CupertinoButton(
                    onPressed: () => setState(() => _showList = !_showList),
                    child: Icon(
                      _showList
                          ? CupertinoIcons.list_bullet
                          : CupertinoIcons.info,
                    ),
                  ),
                ),
              ),
              Expanded(child: _showList ? listWidget : detailsWidget),
            ],
          );
        } else {
          return Row(
            children: [
              listWidget,
              Expanded(child: detailsWidget),
            ],
          );
        }
      },
    );
  }
}
