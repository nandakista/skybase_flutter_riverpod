import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

final secureStorageManagerProvider = Provider<SecureStorageManager>((ref) {
  final secureStorage = ref.read(flutterSecureStorageProvider);
  return SecureStorageManager(secureStorage: secureStorage);
});

class SecureStorageManager {
  final FlutterSecureStorage secureStorage;
  SecureStorageManager({required this.secureStorage});


  final String _tokenKey = 'token';
  final String _refreshTokenKey = 'refresh_token';

  Future<bool> isLoggedIn() async {
    return (await getToken() != '');
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  Future setToken({required String? value}) async {
    return await secureStorage.write(key: _tokenKey, value: value);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenKey);
  }

  Future setRefreshToken({required String? value}) async {
    return await secureStorage.write(key: _refreshTokenKey, value: value);
  }

  Future logout() async {
    await setToken(value: '');
    await setRefreshToken(value: '');
  }
}
