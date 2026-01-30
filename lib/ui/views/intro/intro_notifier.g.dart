// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IntroNotifier)
const introProvider = IntroNotifierProvider._();

final class IntroNotifierProvider
    extends $NotifierProvider<IntroNotifier, IntroState> {
  const IntroNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'introProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$introNotifierHash();

  @$internal
  @override
  IntroNotifier create() => IntroNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntroState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntroState>(value),
    );
  }
}

String _$introNotifierHash() => r'dc02aa34c8332bdc302e40837e1f5adb91518b92';

abstract class _$IntroNotifier extends $Notifier<IntroState> {
  IntroState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<IntroState, IntroState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<IntroState, IntroState>, IntroState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
