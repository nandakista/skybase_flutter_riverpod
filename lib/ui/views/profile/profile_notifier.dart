import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<User>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return ProfileNotifier(repository: authRepository);
});

class ProfileNotifier extends StateNotifier<AsyncValue<User>> {
  final AuthRepository repository;
  final CancelToken cancelToken = CancelToken();

  ProfileNotifier({required this.repository}): super(const AsyncLoading()) {
    onGetProfile();
  }

  Future<void> onGetProfile() async {
    state = const AsyncLoading();
    try {
      final response = await repository.getProfile(
        requestParams: RequestParams(cancelToken: cancelToken),
        username: 'nandakista',
      );
      state = AsyncData(response);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }
}
