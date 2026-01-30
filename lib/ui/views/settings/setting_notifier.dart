import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/localization/locale_notifier.dart';

part 'setting_notifier.g.dart';

@riverpod
class SettingNotifier extends _$SettingNotifier {
  late final AuthManager _authManager;
  late final LocaleNotifier _localeNotifier;
  late final StorageManager _storageManager;

  @override
  String build() {
    _authManager = ref.read(authManagerProvider.notifier);
    _localeNotifier = ref.read(localeProvider.notifier);
    _storageManager = ref.read(storageManagerProvider);

    return _storageManager.get<String?>(StorageKey.CURRENT_LOCALE) ?? 'id';
  }

  void onUpdateLocale(
    BuildContext context, {
    required String languageCode,
  }) {
    state = languageCode;
    _storageManager.save(
      StorageKey.CURRENT_LOCALE,
      languageCode,
    );

    _localeNotifier.updateLocale(
      context,
      Locale(languageCode),
    );
  }

  Future<void> onLogout(BuildContext context) async {
    LoadingDialog.show(context);
    await _authManager.logout();
  }
}
