import 'package:flutter/cupertino.dart';
import '../models.dart';

class ServerInfoTab extends StatelessWidget {
  final ServerInfo serverInfo;

  const ServerInfoTab({super.key, required this.serverInfo});

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
                child: Text('Hostname', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverInfo.hostname, softWrap: true),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Uptime', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${serverInfo.uptime}', softWrap: true),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Server ID', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverInfo.serverId, softWrap: true),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Deployment ID', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverInfo.deploymentId, softWrap: true),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Node Versions', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverInfo.nodeVersions, softWrap: true),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Extension Sync | Total Sync All Count',
                  softWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${serverInfo.extensionSync.totalSyncAllCount}',
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
