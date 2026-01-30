import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources_impl.dart';

import '../../../../config/network/api_request.dart';

// final sampleFeatureSourcesProvider =
// Provider<SampleFeatureSources>((ref) {
//   final apiRequest = ref.read(apiRequestProvider);
//   return SampleFeatureSourcesImpl(apiRequest: apiRequest);
// });

part 'sample_feature_sources.g.dart';

@Riverpod(keepAlive: true)
SampleFeatureSources sampleFeatureSources(Ref ref) {
  final apiRequest = ref.read(apiRequestProvider);
  return SampleFeatureSourcesImpl(apiRequest: apiRequest);
}

abstract interface class SampleFeatureSources {
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
    String? username,
  });

  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<SampleFeature>> getFollowers({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<SampleFeature>> getFollowings({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<Repo>> getRepos({
    required CancelToken cancelToken,
    required String username,
  });
}
