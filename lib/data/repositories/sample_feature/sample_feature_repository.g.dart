// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sampleFeatureRepository)
const sampleFeatureRepositoryProvider = SampleFeatureRepositoryProvider._();

final class SampleFeatureRepositoryProvider extends $FunctionalProvider<
    SampleFeatureRepository,
    SampleFeatureRepository,
    SampleFeatureRepository> with $Provider<SampleFeatureRepository> {
  const SampleFeatureRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sampleFeatureRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sampleFeatureRepositoryHash();

  @$internal
  @override
  $ProviderElement<SampleFeatureRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SampleFeatureRepository create(Ref ref) {
    return sampleFeatureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SampleFeatureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SampleFeatureRepository>(value),
    );
  }
}

String _$sampleFeatureRepositoryHash() =>
    r'e858f71316365e24ab8a1e3a9ff34164a9225d32';
