import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/base/pagination_state.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

final sampleFeatureListNotifierProvider =
    StateNotifierProvider<SampleFeatureListNotifier, PaginationState>((ref) {
  final sampleFeatureRepository = ref.read(sampleFeatureRepositoryProvider);
  return SampleFeatureListNotifier(repository: sampleFeatureRepository);
});

class SampleFeatureListNotifier extends StateNotifier<PaginationState> {
  final SampleFeatureRepository repository;
  final CancelToken cancelToken = CancelToken();

  SampleFeatureListNotifier({required this.repository})
      : super(PaginationState());

  Future<List<SampleFeature>> onGetUsers({
    required int page,
    required int perPage,
    bool? hasMore,
    String? sort,
  }) async {
    final items = await repository.getUsers(
      requestParams: RequestParams(cancelToken: cancelToken),
      page: page,
      perPage: perPage,
      username: state.search,
    );
    state = state.copyWith(page: page + 1, hasMore: items.length == perPage);
    log('state after = ${state.toString()}');
    return items;
  }

  Future<void> onRefresh({
    required PagingController<int, SampleFeature> pagingController,
  }) async {
    state = state.copyWith(page: 1, hasMore: true, search: null);
    pagingController.refresh();
  }

  void updateSearch({required String? search}) {
    state = state.copyWith(page: 1, search: search, hasMore: true);
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }
}
