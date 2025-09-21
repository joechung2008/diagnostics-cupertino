import 'package:flutter/cupertino.dart';
import '../models.dart';

class StageDefinitionWidget extends StatelessWidget {
  final StageDefinition stageDefinition;

  const StageDefinitionWidget({super.key, required this.stageDefinition});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stage Definitions',
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
            for (var entry in stageDefinition.stageDefinition.entries)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.key, softWrap: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.value.join(', '), softWrap: true),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
