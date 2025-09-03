import 'dart:async';
import 'dart:convert';

import 'package:skybase/config/themes/theme_manager.dart';

import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/database/storage/cache_data.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authManagerProvider = StateNotifierProvider<AuthManager, AppType>((ref) {
  final themeManager = ref.read(themeManagerProvider.notifier);
  final storageManager = ref.read(storageManagerProvider);
  final secureStorage = ref.read(secureStorageManagerProvider);
  return AuthManager(
      storage: storageManager,
      secureStorage: secureStorage,
      themeManager: themeManager);
});

enum AppType { INITIAL, FIRST_INSTALL, UNAUTHENTICATED, AUTHENTICATED }

class AuthManager extends StateNotifier<AppType> {
  final StorageManager storage;
  final SecureStorageManager secureStorage;
  final ThemeManager themeManager;

  AuthManager({
    required this.storage,
    required this.secureStorage,
    required this.themeManager,
  }) : super(AppType.INITIAL) {
    _init();
  }

  Future<void> _init() async {
    await setup();
  }

  Future<void> setup() async {
    checkFirstInstall();
    await checkAppTheme();
    await clearExpiredCache();
  }

  Future<void> clearExpiredCache() async {
    await Future.wait(
      storage.sharedPreferences.getKeys().map((key) async {
        List<String> permanentKeys = [
          StorageKey.FIRST_INSTALL,
          StorageKey.CURRENT_LOCALE,
          StorageKey.IS_DARK_THEME,
          StorageKey.USERS,
        ];

        if (!permanentKeys.contains(key)) {
          final now = DateTime.now();
          dynamic storageItem = await storage.get(key);
          CacheData cacheData = CacheData.fromJson(jsonDecode(storageItem));
          if (cacheData.expiredDate.isBefore(now)) await storage.delete(key);
        }
      }),
    );
  }

  void checkFirstInstall() async {
    final bool isFirstInstall =
        await storage.get(StorageKey.FIRST_INSTALL) ?? true;
    if (isFirstInstall) {
      await secureStorage.setToken(value: '');
      state = AppType.FIRST_INSTALL;
    } else {
      checkUser();
    }
  }

  Future<void> checkAppTheme() async {
    final bool isDarkTheme =
        await storage.get(StorageKey.IS_DARK_THEME) ?? false;
    if (isDarkTheme) {
      themeManager.toDarkMode();
    } else {
      themeManager.toLightMode();
    }
  }

  Future<void> checkUser() async {
    final String? token = await secureStorage.getToken();
    if (token != null && token.isNotEmpty) {
      setAuth();
    } else {
      logout();
    }
  }

  void setAuth() async {
    if (await secureStorage.isLoggedIn()) {
      state = AppType.AUTHENTICATED;
    }
  }

  Future<void> logout() async {
    await clearData();
    state = AppType.UNAUTHENTICATED;
  }

  Future<void> clearData() async {
    await secureStorage.logout();
    await storage.logout();
  }

  Future<void> login({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveAuthData(user: user, token: token, refreshToken: refreshToken);
    setAuth();
  }

  Future<void> saveAuthData({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveUserData(user: user);
    await secureStorage.setToken(value: token);
    await secureStorage.setRefreshToken(value: refreshToken);
  }

  Future<void> saveUserData({required User user}) async {
    await storage.save<String>(StorageKey.USERS, jsonEncode(user.toJson()));
  }

  User? get user {
    if (storage.has(StorageKey.USERS)) {
      return User.fromJson(
        jsonDecode(storage.get<String>(StorageKey.USERS)),
      );
    } else {
      return null;
    }
  }

  void onAuthChanged(AppType state) {
    switch (state) {
      case AppType.INITIAL:
        break;
      case AppType.FIRST_INSTALL:
        Navigation.instance.pushAllReplacementNoContext(IntroView.route);
        break;
      case AppType.UNAUTHENTICATED:
        Navigation.instance.pushAllReplacementNoContext(LoginView.route);
        break;
      case AppType.AUTHENTICATED:
        Navigation.instance.pushAllReplacementNoContext(MainNavView.route);
        break;
    }
  }
}
