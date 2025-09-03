import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/views/intro/intro_data.dart';
import 'package:skybase/ui/views/intro/intro_notifier.dart';
import 'package:skybase/ui/views/intro/widgets/intro_indicator.dart';

import 'widgets/intro_content.dart';

class IntroView extends ConsumerWidget {
  static const String route = '/intro';

  const IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introState = ref.watch(introNotifierProvider);
    final notifier = ref.read(introNotifierProvider.notifier);
    final Navigation navigation = ref.read(navigationProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (introState.isFirstPage)
                      ? const SizedBox.shrink()
                      : InkWell(
                    onTap: () =>
                        introState.pageController.jumpToPage(2),
                    child: const Icon(Icons.arrow_back),
                  ),
                  introState.isLastPage
                      ? const SizedBox.shrink()
                      : GestureDetector(
                    onTap: () =>
                        introState.pageController.jumpToPage(2),
                    child: const Text(
                      "Lewati",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: introItem.length,
                controller: introState.pageController,
                itemBuilder: (context, index) {
                  final item = introItem[index];
                  return IntroContent(
                    image: item.image,
                    title: item.tittle,
                    description: item.description,
                  );
                },
                onPageChanged: (index) {
                  notifier.onChangePage(index);
                },
              ),
            ),
            const SizedBox(height: 46),
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: Visibility(
                      visible: !introState.isFirstPage,
                      child: InkWell(
                        onTap: () => notifier.onPreviousPage(),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  IntroIndicator(
                    itemCount: introItem.length,
                    currentIndex: introState.currentIndex,
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    width: 40,
                    child: Visibility(
                      visible: introState.isLastPage,
                      child: GestureDetector(
                        onTap: () => notifier.onNextPage(context, navigation),
                        child: const Text(
                          "Done",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
