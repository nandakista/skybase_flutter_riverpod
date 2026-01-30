// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileRepositoryNotifier)
const profileRepositoryProvider = ProfileRepositoryNotifierProvider._();

final class ProfileRepositoryNotifierProvider
    extends $AsyncNotifierProvider<ProfileRepositoryNotifier, List<Repo>> {
  const ProfileRepositoryNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryNotifierHash();

  @$internal
  @override
  ProfileRepositoryNotifier create() => ProfileRepositoryNotifier();
}

String _$profileRepositoryNotifierHash() =>
    r'692436556da979ea9d0cf2e40515c73e3128514e';

abstract class _$ProfileRepositoryNotifier extends $AsyncNotifier<List<Repo>> {
  FutureOr<List<Repo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Repo>>, List<Repo>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Repo>>, List<Repo>>,
        AsyncValue<List<Repo>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
