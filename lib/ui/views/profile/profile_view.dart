import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';
import 'package:skybase/ui/widgets/base/error_view.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

import 'component/repository/profile_repository_view.dart';

class ProfileView extends ConsumerWidget {
  static const String route = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);
    final Navigation navigation = ref.read(navigationProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () =>
                  navigation.push(context, SettingView.route),
              icon: Icon(
                CupertinoIcons.settings,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: state.when(
          loading: () => PlatformLoadingIndicator(),
          error: (err, st) => ErrorView(
            errorTitle: err.toString(),
            onRetry: () => notifier.onGetProfile(),
          ),
          data: (user) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: RefreshIndicator(
              onRefresh: () async {
                await notifier.onGetProfile();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SkyImage(
                      shapeImage: ShapeImage.circle,
                      size: 40,
                      src: '${user.avatarUrl}&s=200',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.name ?? '--',
                      style: AppStyle.headline3,
                    ),
                    Text(user.bio ?? '--'),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${user.repository ?? 0}',
                              style: AppStyle.headline3,
                            ),
                            const Text('Repository'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${user.followers ?? 0}',
                              style: AppStyle.headline3,
                            ),
                            const Text('Follower'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${user.following ?? 0}',
                              style: AppStyle.headline3,
                            ),
                            const Text('Following'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.location_city),
                        Text(' ${user.company ?? '--'}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        Text(' ${user.location ?? '--'}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.black38),
                    Row(
                      children: [
                        Text('Repository List', style: AppStyle.headline3),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const ProfileRepositoryView(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        )
        // body: Consumer<ProfileNotifier>(
        //   builder: (context, notifier, child) {
        //     return StateView.page(
        //       loadingEnabled: notifier.isLoading,
        //       errorEnabled: notifier.isError,
        //       emptyEnabled: false,
        //       errorTitle: notifier.errorMessage,
        //       onRetry: () => notifier.onRefresh(context),
        //       onRefresh: () => notifier.onRefresh(context),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 24),
        //         child: Column(
        //           children: [
        //             SkyImage(
        //               shapeImage: ShapeImage.circle,
        //               size: 40,
        //               src: '${notifier.dataObj?.avatarUrl}&s=200',
        //             ),
        //             const SizedBox(height: 12),
        //             Text(
        //               notifier.dataObj?.name ?? '--',
        //               style: AppStyle.headline3,
        //             ),
        //             Text(notifier.dataObj?.bio ?? '--'),
        //             const SizedBox(height: 24),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   children: [
        //                     Text(
        //                       '${notifier.dataObj?.repository ?? 0}',
        //                       style: AppStyle.headline3,
        //                     ),
        //                     const Text('Repository'),
        //                   ],
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       '${notifier.dataObj?.followers ?? 0}',
        //                       style: AppStyle.headline3,
        //                     ),
        //                     const Text('Follower'),
        //                   ],
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       '${notifier.dataObj?.following ?? 0}',
        //                       style: AppStyle.headline3,
        //                     ),
        //                     const Text('Following'),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //             const SizedBox(height: 24),
        //             Row(
        //               children: [
        //                 const Icon(Icons.location_city),
        //                 Text(' ${notifier.dataObj?.company ?? '--'}'),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Icon(Icons.location_on),
        //                 Text(' ${notifier.dataObj?.location ?? '--'}'),
        //               ],
        //             ),
        //             const SizedBox(height: 8),
        //             const Divider(color: Colors.black38),
        //             Row(
        //               children: [
        //                 Text('Repository List', style: AppStyle.headline3),
        //               ],
        //             ),
        //             const SizedBox(height: 12),
        //             const ProfileRepositoryView(),
        //             const SizedBox(height: 12),
        //           ],
        //         ),
        //       ),
        //     );
        //   }
        // ),
        );
  }
}
