import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('Environment', () {
    test('should have correct URLs for each environment', () {
      expect(
        Environment.public.url,
        'https://hosting.portal.azure.net/api/diagnostics',
      );
      expect(
        Environment.fairfax.url,
        'https://hosting.azureportal.usgovcloudapi.net/api/diagnostics',
      );
      expect(
        Environment.mooncake.url,
        'https://hosting.azureportal.chinacloudapi.cn/api/diagnostics',
      );
    });

    test('should have correct display names', () {
      expect(Environment.public.displayName, 'Public Cloud');
      expect(Environment.fairfax.displayName, 'Fairfax');
      expect(Environment.mooncake.displayName, 'Mooncake');
    });

    test('should return correct values for all environments', () {
      final environments = Environment.values;
      expect(environments.length, 3);
      expect(environments, contains(Environment.public));
      expect(environments, contains(Environment.fairfax));
      expect(environments, contains(Environment.mooncake));
    });
  });
}
