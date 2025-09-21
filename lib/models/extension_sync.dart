class ExtensionSync {
  final num totalSyncAllCount;

  ExtensionSync({required this.totalSyncAllCount});

  factory ExtensionSync.fromJson(Map<String, dynamic> json) {
    return ExtensionSync(
      totalSyncAllCount: json['totalSyncAllCount'] is num
          ? json['totalSyncAllCount']
          : 0,
    );
  }
}
