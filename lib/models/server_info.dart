import 'extension_sync.dart';

class ServerInfo {
  final String deploymentId;
  final ExtensionSync extensionSync;
  final String hostname;
  final String nodeVersions;
  final String serverId;
  final num uptime;

  ServerInfo({
    required this.deploymentId,
    required this.extensionSync,
    required this.hostname,
    required this.nodeVersions,
    required this.serverId,
    required this.uptime,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      deploymentId: json['deploymentId']?.toString() ?? '',
      extensionSync: json['extensionSync'] is Map<String, dynamic>
          ? ExtensionSync.fromJson(json['extensionSync'])
          : ExtensionSync(totalSyncAllCount: 0),
      hostname: json['hostname']?.toString() ?? '',
      nodeVersions: json['nodeVersions']?.toString() ?? '',
      serverId: json['serverId']?.toString() ?? '',
      uptime: json['uptime'] is num ? json['uptime'] : 0,
    );
  }
}
