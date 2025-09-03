import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final profileNotifierRepositoryProvider = StateNotifierProvider<ProfileRepositoryNotifier, AsyncValue<List<Repo>>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return ProfileRepositoryNotifier(repository: authRepository);
});

class ProfileRepositoryNotifier extends StateNotifier<AsyncValue<List<Repo>>> {
  final AuthRepository repository;
  final CancelToken cancelToken = CancelToken();

  ProfileRepositoryNotifier({required this.repository}) : super(const AsyncValue.loading()) {
    onGetRepository();
  }

  Future<void> onGetRepository() async {
    try {
      state = const AsyncLoading();
      final response = await repository.getProfileRepository(
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