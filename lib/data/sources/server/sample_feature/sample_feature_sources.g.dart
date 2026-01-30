// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_sources.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sampleFeatureSources)
const sampleFeatureSourcesProvider = SampleFeatureSourcesProvider._();

final class SampleFeatureSourcesProvider extends $FunctionalProvider<
    SampleFeatureSources,
    SampleFeatureSources,
    SampleFeatureSources> with $Provider<SampleFeatureSources> {
  const SampleFeatureSourcesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sampleFeatureSourcesProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sampleFeatureSourcesHash();

  @$internal
  @override
  $ProviderElement<SampleFeatureSources> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SampleFeatureSources create(Ref ref) {
    return sampleFeatureSources(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SampleFeatureSources value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SampleFeatureSources>(value),
    );
  }
}

String _$sampleFeatureSourcesHash() =>
    r'61823ef7b76d5ace40abb51e604d4381cfec12eb';
