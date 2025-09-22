import 'package:flutter/foundation.dart';

import 'environment.dart';
import 'diagnostics.dart';
import 'extension_info.dart';

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
  // Sentinel used to differentiate "no change" from explicit null
  static const _noChange = Object();

  DashboardState copyWith({
    Environment? selectedEnvironment,
    Object? diagnostics = _noChange,
    bool? isLoading,
    Object? error = _noChange,
    Object? selectedExtension = _noChange,
  }) {
    return DashboardState(
      selectedEnvironment: selectedEnvironment ?? this.selectedEnvironment,
      diagnostics: identical(diagnostics, _noChange)
          ? this.diagnostics
          : diagnostics as Diagnostics?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _noChange) ? this.error : error as String?,
      // If the caller passed the sentinel, keep the current value; otherwise
      // use the provided value (which may be null to explicitly clear).
      selectedExtension: identical(selectedExtension, _noChange)
          ? this.selectedExtension
          : selectedExtension as ExtensionInfo?,
    );
  }
}
