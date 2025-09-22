import 'package:flutter_test/flutter_test.dart';
import 'package:diagnostics_cupertino/models.dart';

void main() {
  group('DashboardState', () {
    test('default constructor values', () {
      const state = DashboardState();

      expect(state.selectedEnvironment, Environment.public);
      expect(state.diagnostics, isNull);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
      expect(state.selectedExtension, isNull);
    });

    test('copyWith updates fields and preserves others', () {
      const initial = DashboardState();

      final updated = initial.copyWith(
        isLoading: true,
        error: 'Something went wrong',
        selectedEnvironment: Environment.fairfax,
      );

      expect(updated.isLoading, isTrue);
      expect(updated.error, 'Something went wrong');
      expect(updated.selectedEnvironment, Environment.fairfax);

      // unchanged fields remain equal
      expect(updated.diagnostics, initial.diagnostics);
      expect(updated.selectedExtension, initial.selectedExtension);
    });

    test('copyWith can set selectedExtension and diagnostics', () {
      const initial = DashboardState();

      final extension = ExtensionInfo(
        extensionName: 'test-ext',
        config: Configuration(config: {}),
      );

      final diagnostics = Diagnostics(
        buildInfo: BuildInfo(buildVersion: '1.0.0'),
        extensions: {'test-ext': Extension(info: extension)},
        serverInfo: ServerInfo(
          deploymentId: 'd',
          extensionSync: ExtensionSync(totalSyncAllCount: 0),
          hostname: 'h',
          nodeVersions: 'v',
          serverId: 's',
          uptime: 0,
        ),
      );

      final updated = initial.copyWith(
        selectedExtension: extension,
        diagnostics: diagnostics,
      );

      expect(updated.selectedExtension, extension);
      expect(updated.diagnostics, diagnostics);
    });

    test('set and then clear selectedExtension via copyWith', () {
      const initial = DashboardState();

      final extension = ExtensionInfo(
        extensionName: 'clear-ext',
        config: Configuration(config: {}),
      );

      final withSel = initial.copyWith(selectedExtension: extension);
      expect(withSel.selectedExtension, extension);

      // Now explicitly clear the selection by passing null
      final cleared = withSel.copyWith(selectedExtension: null);
      expect(cleared.selectedExtension, isNull);
    });

    test('set and then clear diagnostics via copyWith', () {
      const initial = DashboardState();

      final diagnostics = Diagnostics(
        buildInfo: BuildInfo(buildVersion: '1.0.0'),
        extensions: {},
        serverInfo: ServerInfo(
          deploymentId: 'd',
          extensionSync: ExtensionSync(totalSyncAllCount: 0),
          hostname: 'h',
          nodeVersions: 'v',
          serverId: 's',
          uptime: 0,
        ),
      );

      final withDiag = initial.copyWith(diagnostics: diagnostics);
      expect(withDiag.diagnostics, diagnostics);

      final cleared = withDiag.copyWith(diagnostics: null);
      expect(cleared.diagnostics, isNull);
    });

    test('set and then clear error via copyWith', () {
      const initial = DashboardState();

      final withError = initial.copyWith(error: 'oops');
      expect(withError.error, 'oops');

      final cleared = withError.copyWith(error: null);
      expect(cleared.error, isNull);
    });
  });
}
