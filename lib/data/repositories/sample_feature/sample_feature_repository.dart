import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

final sampleFeatureRepositoryProvider = Provider<SampleFeatureRepository>((ref) {
  final apiService = ref.watch(sampleFeatureSourcesProvider);
  final storageManager = ref.watch(storageManagerProvider);
  return SampleFeatureRepositoryImpl(apiService: apiService, storageManager: storageManager);
});

abstract interface class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required RequestParams requestParams,
    required int page,
    required int perPage,
    String? username,
  });

  Future<SampleFeature> getDetailUser({
    required RequestParams requestParams,
    required int id,
    required String username,
  });
}
