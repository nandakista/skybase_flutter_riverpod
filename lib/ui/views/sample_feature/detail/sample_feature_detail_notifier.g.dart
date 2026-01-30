// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SampleFeatureDetailNotifier)
const sampleFeatureDetailProvider = SampleFeatureDetailNotifierFamily._();

final class SampleFeatureDetailNotifierProvider
    extends $AsyncNotifierProvider<SampleFeatureDetailNotifier, SampleFeature> {
  const SampleFeatureDetailNotifierProvider._(
      {required SampleFeatureDetailNotifierFamily super.from,
      required ({
        int userId,
        String username,
      })
          super.argument})
      : super(
          retry: null,
          name: r'sampleFeatureDetailProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sampleFeatureDetailNotifierHash();

  @override
  String toString() {
    return r'sampleFeatureDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SampleFeatureDetailNotifier create() => SampleFeatureDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is SampleFeatureDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sampleFeatureDetailNotifierHash() =>
    r'b830bd574d5d1125d26839ae651d4122b81e8670';

final class SampleFeatureDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
            SampleFeatureDetailNotifier,
            AsyncValue<SampleFeature>,
            SampleFeature,
            FutureOr<SampleFeature>,
            ({
              int userId,
              String username,
            })> {
  const SampleFeatureDetailNotifierFamily._()
      : super(
          retry: null,
          name: r'sampleFeatureDetailProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SampleFeatureDetailNotifierProvider call({
    required int userId,
    required String username,
  }) =>
      SampleFeatureDetailNotifierProvider._(argument: (
        userId: userId,
        username: username,
      ), from: this);

  @override
  String toString() => r'sampleFeatureDetailProvider';
}

abstract class _$SampleFeatureDetailNotifier
    extends $AsyncNotifier<SampleFeature> {
  late final _$args = ref.$arg as ({
    int userId,
    String username,
  });
  int get userId => _$args.userId;
  String get username => _$args.username;

  FutureOr<SampleFeature> build({
    required int userId,
    required String username,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      userId: _$args.userId,
      username: _$args.username,
    );
    final ref = this.ref as $Ref<AsyncValue<SampleFeature>, SampleFeature>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<SampleFeature>, SampleFeature>,
        AsyncValue<SampleFeature>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
