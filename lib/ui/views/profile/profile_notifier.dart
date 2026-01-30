import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  late final AuthRepository _repository;
  late final CancelToken _cancelToken;

  @override
  Future<User> build() async {
    _repository = ref.read(authRepositoryProvider);
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken.cancel();
    });
    return _getProfile();
  }

  Future<User> _getProfile() async {
    return await _repository.getProfile(
      requestParams: RequestParams(cancelToken: _cancelToken),
      username: 'nandakista',
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getProfile);
  }
}
