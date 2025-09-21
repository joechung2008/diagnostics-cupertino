// Data models for the diagnostics dashboard

enum Environment {
  public('https://hosting.portal.azure.net/api/diagnostics', 'Public Cloud'),
  fairfax(
    'https://hosting.azureportal.usgovcloudapi.net/api/diagnostics',
    'Fairfax',
  ),
  mooncake(
    'https://hosting.azureportal.chinacloudapi.cn/api/diagnostics',
    'Mooncake',
  );

  const Environment(this.url, this.displayName);
  final String url;
  final String displayName;
}
