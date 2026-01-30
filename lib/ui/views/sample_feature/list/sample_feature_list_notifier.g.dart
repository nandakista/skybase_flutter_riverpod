// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SampleFeatureListNotifier)
const sampleFeatureListProvider = SampleFeatureListNotifierProvider._();

final class SampleFeatureListNotifierProvider
    extends $NotifierProvider<SampleFeatureListNotifier, PaginationState> {
  const SampleFeatureListNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sampleFeatureListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sampleFeatureListNotifierHash();

  @$internal
  @override
  SampleFeatureListNotifier create() => SampleFeatureListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaginationState>(value),
    );
  }
}

String _$sampleFeatureListNotifierHash() =>
    r'f803e531492dd5e3415f94ebf41b3c6cfe72fcf5';

abstract class _$SampleFeatureListNotifier extends $Notifier<PaginationState> {
  PaginationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PaginationState, PaginationState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaginationState, PaginationState>,
        PaginationState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
