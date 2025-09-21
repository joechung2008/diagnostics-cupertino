import 'package:flutter/cupertino.dart';
import '../models.dart';

class ConfigurationWidget extends StatelessWidget {
  final Configuration config;

  const ConfigurationWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configuration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Table(
          border: TableBorder.all(),
          columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Key',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            for (var entry in config.config.entries)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.key, softWrap: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.value, softWrap: true),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
