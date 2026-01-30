import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'profile_repository_notifier.g.dart';

@riverpod
class ProfileRepositoryNotifier extends _$ProfileRepositoryNotifier {
  late final CancelToken _cancelToken;

  @override
  Future<List<Repo>> build() async {
    _cancelToken = CancelToken();
    ref.onDispose(() {
      _cancelToken.cancel();
    });

    return _getProfileRepository();
  }

  Future<List<Repo>> _getProfileRepository() async {
    final repository = ref.read(authRepositoryProvider);
    return await repository.getProfileRepository(
      requestParams: RequestParams(cancelToken: _cancelToken),
      username: 'nandakista',
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getProfileRepository);
  }
}
