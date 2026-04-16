import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    await _init();
    return await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    // Note: This needs the prefs to be initialized. 
    // Usually in these architectures, init is called at app startup.
    return _prefs?.getString(key);
  }

  Future<bool> clear() async {
    await _init();
    return await _prefs!.clear();
  }
}
