import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:skybase/config/base/pagination_state.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_list_notifier.g.dart';

@riverpod
class SampleFeatureListNotifier extends _$SampleFeatureListNotifier {
  late final SampleFeatureRepository _repository;
  late final CancelToken _cancelToken;

  @override
  PaginationState build() {
    _repository = ref.read(sampleFeatureRepositoryProvider);
    _cancelToken = CancelToken();
    ref.onDispose(() {
      _cancelToken.cancel();
    });
    return PaginationState();
  }

  Future<List<SampleFeature>> onGetUsers({
    required int page,
    required int perPage,
    bool? hasMore,
    String? sort,
  }) async {
    final items = await _repository.getUsers(
      requestParams: RequestParams(cancelToken: _cancelToken),
      page: page,
      perPage: perPage,
      username: state.search,
    );

    state = state.copyWith(
      page: page + 1,
      hasMore: items.length == perPage,
    );

    log('state after = $state');
    return items;
  }

  Future<void> onRefresh({
    required PagingController<int, SampleFeature> pagingController,
  }) async {
    state = state.copyWith(
      page: 1,
      hasMore: true,
      search: null,
    );
    pagingController.refresh();
  }
}
