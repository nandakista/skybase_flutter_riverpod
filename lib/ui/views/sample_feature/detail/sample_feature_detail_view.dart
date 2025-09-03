import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_notifier.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/error_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends ConsumerWidget {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({
    super.key,
    required this.usernameArgs,
    required this.userId,
  });

  final int userId;
  final String usernameArgs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userDetailProvider((userId, usernameArgs)));
    final notifier =
        ref.read(userDetailProvider((userId, usernameArgs)).notifier);

    return Scaffold(
      appBar: SkyAppBar.primary(title: usernameArgs),
      body: SafeArea(
        child: state.when(
          loading: () => const ShimmerSampleFeatureDetail(),
          error: (err, st) => ErrorView(
            errorTitle: err.toString(),
            onRetry: () => notifier.onGetDetailUser(),
          ),
          data: (user) => Column(
            children: [
              SampleFeatureDetailHeader(
                avatar: user.avatarUrl ?? '',
                repositoryCount: user.repository ?? 0,
                followerCount: user.followers ?? 0,
                followingCount: user.following ?? 0,
              ),
              SampleFeatureDetailInfo(
                name: user.name ?? '',
                bio: user.bio ?? '',
                company: user.company ?? '',
                location: user.location ?? '',
              ),
              SampleFeatureDetailTab(data: user),
            ],
          ),
        ),
      ),
    );
  }
}
