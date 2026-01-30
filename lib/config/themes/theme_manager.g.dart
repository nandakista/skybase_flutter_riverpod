// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeManager)
const themeManagerProvider = ThemeManagerProvider._();

final class ThemeManagerProvider extends $NotifierProvider<ThemeManager, bool> {
  const ThemeManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeManagerHash();

  @$internal
  @override
  ThemeManager create() => ThemeManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$themeManagerHash() => r'5deb49b9788448d9bc204a4a47cc55de574521c7';

abstract class _$ThemeManager extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
