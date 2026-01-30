import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  late final AuthRepository _repository;
  late final AuthManager _authManager;
  late final CancelToken _cancelToken;

  @override
  AsyncValue<bool?> build() {
    _repository = ref.read(authRepositoryProvider);
    _authManager = ref.read(authManagerProvider.notifier);
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken.cancel();
    });

    return const AsyncValue.data(null);
  }

  Future<void> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.login(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
      return true;
    });
  }

  Future<void> bypassLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _repository.getProfile(
        requestParams: RequestParams(cancelToken: _cancelToken),
        username: 'nandakista',
      );

      await _authManager.login(
        user: response,
        token: 'dummy',
        refreshToken: 'dummyRefresh',
      );

      return true;
    });
  }
}
