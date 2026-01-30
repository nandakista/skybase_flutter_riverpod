import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skybase/config/base/navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/views/login/login_view.dart';

part 'intro_notifier.g.dart';

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

@riverpod
class IntroNotifier extends _$IntroNotifier {
  late final StorageManager _storageManager;
  late final PageController _pageController;

  @override
  IntroState build() {
    _storageManager = ref.read(storageManagerProvider);

    _pageController = PageController(initialPage: 0);
    ref.onDispose(() {
      _pageController.dispose(); // ✅ WAJIB
    });

    return IntroState(
      currentIndex: 0,
      pageController: _pageController,
    );
  }

  void onChangePage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void onPreviousPage() {
    _pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
  }

  void onNextPage(BuildContext context, Navigation navigation) {
    if (!state.isLastPage) {
      _pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 260),
      );
    } else {
      _storageManager.save(StorageKey.FIRST_INSTALL, false);
      navigation.push(context, LoginView.route);
    }
  }
}
