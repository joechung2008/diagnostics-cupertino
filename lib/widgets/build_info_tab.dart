import 'package:flutter/cupertino.dart';
import '../models.dart';

class BuildInfoTab extends StatelessWidget {
  final BuildInfo buildInfo;

  const BuildInfoTab({super.key, required this.buildInfo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Name',
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
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Build Version', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(buildInfo.buildVersion, softWrap: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
