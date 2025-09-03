import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<bool?>>((ref) {
  final repository = ref.read(authRepositoryProvider);
  final authManager = ref.read(authManagerProvider.notifier);
  return LoginNotifier(repository: repository, authManager: authManager);
});

class LoginNotifier extends StateNotifier<AsyncValue<bool?>> {
  final AuthRepository repository;
  final AuthManager authManager;
  final CancelToken cancelToken = CancelToken();

  LoginNotifier({
    required this.repository,
    required this.authManager,
  }) : super(const AsyncValue.data(null));

  Future<void> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      state = AsyncValue.loading();
      await repository.login(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
      state = AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> bypassLogin(BuildContext context) async {
    try {
      state = const AsyncValue.loading();
      final response = await repository.getProfile(
        requestParams: RequestParams(cancelToken: cancelToken),
        username: 'nandakista',
      );

      await authManager.login(
        user: response,
        token: 'dummy',
        refreshToken: 'dummyRefresh',
      );
      state = const AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }
}
