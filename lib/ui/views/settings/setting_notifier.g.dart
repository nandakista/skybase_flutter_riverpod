// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingNotifier)
const settingProvider = SettingNotifierProvider._();

final class SettingNotifierProvider
    extends $NotifierProvider<SettingNotifier, String> {
  const SettingNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingNotifierHash();

  @$internal
  @override
  SettingNotifier create() => SettingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$settingNotifierHash() => r'492736ccd3213976de572abbea8a489db0705cc3';

abstract class _$SettingNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
