import 'package:flutter/cupertino.dart';
import '../models.dart';
import '../services.dart';
import '../widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.diagnosticsService});

  final DiagnosticsService? diagnosticsService;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final CupertinoTabController _tabController;
  late final ValueNotifier<DashboardState> _dashboardState;
  late final DiagnosticsService _diagnosticsService;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
    _dashboardState = ValueNotifier(const DashboardState());
    _diagnosticsService = widget.diagnosticsService ?? DiagnosticsService();

    // Load initial data
    _loadDiagnostics();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dashboardState.dispose();
    super.dispose();
  }

  Future<void> _loadDiagnostics() async {
    _dashboardState.value = _dashboardState.value.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final diagnostics = await _diagnosticsService.fetchDiagnostics(
        _dashboardState.value.selectedEnvironment,
      );
      _dashboardState.value = _dashboardState.value.copyWith(
        diagnostics: diagnostics,
        isLoading: false,
        selectedExtension: null, // Clear selection on new data
      );
    } catch (e) {
      _dashboardState.value = _dashboardState.value.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void _onEnvironmentChanged(Environment? newEnvironment) {
    if (newEnvironment != null &&
        newEnvironment != _dashboardState.value.selectedEnvironment) {
      _dashboardState.value = _dashboardState.value.copyWith(
        selectedEnvironment: newEnvironment,
        selectedExtension: null,
      );
      _loadDiagnostics();
    }
  }

  void _onExtensionSelected(ExtensionInfo extension) {
    _dashboardState.value = _dashboardState.value.copyWith(
      selectedExtension: extension,
    );
  }

  void _onShortcutPressed(String extensionName) {
    final diagnostics = _dashboardState.value.diagnostics;
    if (diagnostics != null) {
      final extension = diagnostics.extensions[extensionName];
      if (extension != null && extension.isInfo) {
        _onExtensionSelected(extension.info!);
        _tabController.index = 0; // Switch to Extensions tab
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Azure Portal Extensions Dashboard'),
      ),
      child: SafeArea(
        child: ValueListenableBuilder<DashboardState>(
          valueListenable: _dashboardState,
          builder: (context, state, _) => DashboardBody(
            state: state,
            tabController: _tabController,
            onEnvironmentChanged: _onEnvironmentChanged,
            onExtensionSelected: _onExtensionSelected,
            onShortcutPressed: _onShortcutPressed,
          ),
        ),
      ),
    );
  }
}

@immutable
class DashboardState {
  const DashboardState({
    this.selectedEnvironment = Environment.public,
    this.diagnostics,
    this.isLoading = false,
    this.error,
    this.selectedExtension,
  });

  final Environment selectedEnvironment;
  final Diagnostics? diagnostics;
  final bool isLoading;
  final String? error;
  final ExtensionInfo? selectedExtension;

  DashboardState copyWith({
    Environment? selectedEnvironment,
    Diagnostics? diagnostics,
    bool? isLoading,
    String? error,
    ExtensionInfo? selectedExtension,
  }) {
    return DashboardState(
      selectedEnvironment: selectedEnvironment ?? this.selectedEnvironment,
      diagnostics: diagnostics ?? this.diagnostics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedExtension: selectedExtension ?? this.selectedExtension,
    );
  }
}
