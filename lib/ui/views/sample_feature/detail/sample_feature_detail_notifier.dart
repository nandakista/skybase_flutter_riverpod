import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_detail_notifier.g.dart';

@riverpod
class SampleFeatureDetailNotifier
    extends _$SampleFeatureDetailNotifier {
  late final SampleFeatureRepository _repository;
  late final CancelToken _cancelToken;

  @override
  Future<SampleFeature> build({
    required int userId,
    required String username,
  }) async {
    _repository = ref.read(sampleFeatureRepositoryProvider);
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken.cancel();
    });

    return _getDetailUser(
      userId: userId,
      username: username,
    );
  }

  Future<SampleFeature> _getDetailUser({
    required int userId,
    required String username,
  }) async {
    return await _repository.getDetailUser(
      requestParams: RequestParams(cancelToken: _cancelToken),
      id: userId,
      username: username,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => _getDetailUser(
        userId: userId,
        username: username,
      ),
    );
  }
}
