import 'package:injectable/injectable.dart';
import 'shared_prefs_helper.dart';
import 'secure_storage_helper.dart';

@lazySingleton
class CacheManager {
  final SharedPrefsHelper _sharedPrefs;
  final SecureStorageHelper _secureStorage;

  CacheManager({
    SharedPrefsHelper? sharedPrefs,
    SecureStorageHelper? secureStorage,
  }) : _sharedPrefs = sharedPrefs ?? SharedPrefsHelper(),
       _secureStorage = secureStorage ?? SecureStorageHelper();

  // Token management
  Future<void> saveTokens({required String access, required String refresh}) async {
    await _secureStorage.write(key: 'access_token', value: access);
    await _secureStorage.write(key: 'refresh_token', value: refresh);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }

  // Generic data caching (Shared Prefs)
  Future<void> cacheData(String key, String value) async {
    await _sharedPrefs.setString(key, value);
  }

  String? getCachedData(String key) {
    return _sharedPrefs.getString(key);
  }

  Future<void> clearAll() async {
    await _sharedPrefs.clear();
    await _secureStorage.deleteAll();
  }
}
