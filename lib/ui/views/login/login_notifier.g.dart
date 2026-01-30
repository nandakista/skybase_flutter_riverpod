// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginNotifier)
const loginProvider = LoginNotifierProvider._();

final class LoginNotifierProvider
    extends $NotifierProvider<LoginNotifier, AsyncValue<bool?>> {
  const LoginNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loginProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loginNotifierHash();

  @$internal
  @override
  LoginNotifier create() => LoginNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool?>>(value),
    );
  }
}

String _$loginNotifierHash() => r'9f18d99f21f00400b73b1dd113b22c801e9c8ade';

abstract class _$LoginNotifier extends $Notifier<AsyncValue<bool?>> {
  AsyncValue<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool?>, AsyncValue<bool?>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool?>, AsyncValue<bool?>>,
        AsyncValue<bool?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
