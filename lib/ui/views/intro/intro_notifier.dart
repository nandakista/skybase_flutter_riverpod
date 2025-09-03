import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/views/login/login_view.dart';

import 'package:flutter/material.dart';

final introNotifierProvider = StateNotifierProvider<IntroNotifier, IntroState>((ref) {
  final storage = ref.read(storageManagerProvider);
  return IntroNotifier(storageManager: storage);
});

class IntroState {
  final int currentIndex;
  final PageController pageController;

  IntroState({
    required this.currentIndex,
    required this.pageController,
  });

  bool get isFirstPage => currentIndex == 0;
  bool get isLastPage => currentIndex == 2;

  IntroState copyWith({
    int? currentIndex,
    PageController? pageController,
  }) {
    return IntroState(
      currentIndex: currentIndex ?? this.currentIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}

class IntroNotifier extends StateNotifier<IntroState> {
  final StorageManager storageManager;

  IntroNotifier({required this.storageManager})
      : super(IntroState(currentIndex: 0, pageController: PageController(initialPage: 0)));

  void onChangePage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void onPreviousPage() {
    state.pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
  }

  void onNextPage(BuildContext context, Navigation navigation) {
    if (!state.isLastPage) {
      state.pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 260),
      );
    } else {
      storageManager.save(StorageKey.FIRST_INSTALL, false);
      navigation.push(context, LoginView.route);
    }
  }
}
