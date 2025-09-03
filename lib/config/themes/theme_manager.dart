import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

final themeManagerProvider = StateNotifierProvider<ThemeManager, bool>((ref) {
  final storageManager = ref.read(storageManagerProvider);
  return ThemeManager(storage: storageManager);
});

class ThemeManager extends StateNotifier<bool> {
  final StorageManager storage;

  ThemeManager({required this.storage})
      : super(storage.get<bool?>(StorageKey.IS_DARK_THEME) ?? false);

  void toDarkMode() {
    state = true;
    storage.save<bool>(StorageKey.IS_DARK_THEME, state);
  }

  void toLightMode() {
    state = false;
    storage.save<bool>(StorageKey.IS_DARK_THEME, state);
  }

  Future<bool> changeTheme() async {
    state = !state;
    storage.save<bool>(StorageKey.IS_DARK_THEME, state);
    return state;
  }
}
