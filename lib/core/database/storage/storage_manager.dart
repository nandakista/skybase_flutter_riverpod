import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybase/core/database/storage/storage_key.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

// final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs;
// });

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final storageManagerProvider = Provider<StorageManager>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return StorageManager(sharedPreferences: prefs);
});

class StorageManager {
  final SharedPreferences sharedPreferences;

  StorageManager({required this.sharedPreferences});

  /// If you want to save Object/Model don't forget to encode toJson
  Future<void> save<T>(String name, T value) async {
    if (value is String) {
      await sharedPreferences.setString(name, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(name, value);
    } else if (value is int) {
      await sharedPreferences.setInt(name, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(name, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(name, value);
    }
  }

  Future<void> delete(String name) async {
    await sharedPreferences.remove(name);
  }

  /// If you want to get Object/Model don't forget to decode fromJson
  T get<T>(String name) {
    return sharedPreferences.get(name) as T;
  }

  bool has(String name) {
    return sharedPreferences.containsKey(name);
  }

  Future<void> logout() async {
    try {
      List<String> permanentKeys = [
        StorageKey.FIRST_INSTALL,
        StorageKey.CURRENT_LOCALE,
        StorageKey.IS_DARK_THEME,
      ];

      List<String> deleteKeys = (sharedPreferences.getKeys()).where((key) {
        return !permanentKeys.contains(key);
      }).toList();

      for (var key in deleteKeys) {
        await sharedPreferences.remove(key);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
