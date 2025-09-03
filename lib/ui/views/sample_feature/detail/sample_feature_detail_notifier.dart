import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

final userDetailProvider = StateNotifierProvider.family<
    SampleFeatureDetailNotifier, AsyncValue<SampleFeature>, (int, String)>(
  (ref, param) {
    final sampleFeatureRepository = ref.read(sampleFeatureRepositoryProvider);
    return SampleFeatureDetailNotifier(
      repository: sampleFeatureRepository,
      userId: param.$1,
      username: param.$2,
    );
  },
);

class SampleFeatureDetailNotifier
    extends StateNotifier<AsyncValue<SampleFeature>> {
  final SampleFeatureRepository repository;
  final CancelToken cancelToken = CancelToken();
  final int userId;
  final String username;

  SampleFeatureDetailNotifier({
    required this.userId,
    required this.username,
    required this.repository,
  }) : super(const AsyncLoading()) {
    onGetDetailUser();
  }

  Future<void> onGetDetailUser() async {
    try {
      state = const AsyncLoading();
      final response = await repository.getDetailUser(
        requestParams: RequestParams(cancelToken: cancelToken),
        id: userId,
        username: username,
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
