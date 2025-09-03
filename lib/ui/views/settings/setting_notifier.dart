import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/localization/locale_manager.dart';

final settingProvider = StateNotifierProvider<SettingNotifier, String>((ref) {
  final authManager = ref.read(authManagerProvider.notifier);
  final localeManager = ref.read(localeNotifierProvider.notifier);
  final storageManager = ref.read(storageManagerProvider);
  return SettingNotifier(
    authManager: authManager,
    localeManager: localeManager,
    storageManager: storageManager,
  );
});

class SettingNotifier extends StateNotifier<String> {
  final AuthManager authManager;
  final LocaleStateNotifier localeManager;
  final StorageManager storageManager;

  SettingNotifier({
    required this.authManager,
    required this.localeManager,
    required this.storageManager,
  }) : super(
          storageManager.get<String?>(StorageKey.CURRENT_LOCALE) ?? 'id',
        );

  void onUpdateLocale(BuildContext context, {required String languageCode}) {
    state = languageCode;
    storageManager.save(StorageKey.CURRENT_LOCALE, languageCode);
    localeManager.updateLocale(context, Locale(languageCode));
  }

  Future<void> onLogout(BuildContext context) async {
    LoadingDialog.show(context);
    await authManager.logout();
  }
}
