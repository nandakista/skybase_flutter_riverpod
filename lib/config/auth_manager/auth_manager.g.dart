// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthManager)
const authManagerProvider = AuthManagerProvider._();

final class AuthManagerProvider
    extends $NotifierProvider<AuthManager, AppType> {
  const AuthManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authManagerHash();

  @$internal
  @override
  AuthManager create() => AuthManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppType>(value),
    );
  }
}

String _$authManagerHash() => r'f06222070a23cd5432f34ba40535581e400abe2c';

abstract class _$AuthManager extends $Notifier<AppType> {
  AppType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppType, AppType>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AppType, AppType>, AppType, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
