import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_notifier.dart';
import 'package:skybase/ui/widgets/base/pagination_state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureListView extends ConsumerStatefulWidget {
  static const String route = '/user-list';

  const SampleFeatureListView({super.key});

  @override
  ConsumerState<SampleFeatureListView> createState() =>
      _SampleFeatureListViewState();
}

class _SampleFeatureListViewState extends ConsumerState<SampleFeatureListView>
    with AutomaticKeepAliveClientMixin {
  static const int _pageSize = 20;
  final PagingController<int, SampleFeature> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _fetchPage(int pageKey) async {
    final notifier = ref.read(sampleFeatureListNotifierProvider.notifier);
    try {
      final newItems =
          await notifier.onGetUsers(page: pageKey, perPage: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.read(sampleFeatureListNotifierProvider.notifier);
    final Navigation navigation = ref.read(navigationProvider);

    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'txt_list_users'.tr()),
      body: PaginationStateView<SampleFeature>.list(
        pagingController: _pagingController,
        loadingView: const ShimmerSampleFeatureList(),
        onRefresh: () =>
            notifier.onRefresh(pagingController: _pagingController),
        onRetry: () => notifier.onRefresh(pagingController: _pagingController),
        itemBuilder: (BuildContext context, item, int index) {
          return ListTile(
            onTap: () {
              navigation.push(
                context,
                SampleFeatureDetailView.route,
                arguments: {
                  'id': item.id,
                  'username': item.username,
                },
              );
            },
            leading: SkyImage(
              shapeImage: ShapeImage.circle,
              size: 30,
              src: '${item.avatarUrl}&s=200',
            ),
            title: Text(item.username.toString()),
            subtitle: Text(
              item.gitUrl.toString(),
              style: AppStyle.body2,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          LoadingDialog.show(context);
          final storageProvider = ref.read(storageManagerProvider);
          await storageProvider.delete(CachedKey.SAMPLE_FEATURE_LIST);
          await storageProvider.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
          if (context.mounted) LoadingDialog.dismiss(context);
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
