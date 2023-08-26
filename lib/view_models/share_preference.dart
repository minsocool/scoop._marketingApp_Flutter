import 'package:shared_preferences/shared_preferences.dart';

class SharePreference {
  Future<String?> read(String key) async {
    final _read = await SharedPreferences.getInstance();
    return _read.getString(key);
  }

  Future<bool> save(String key, String value) async {
    final _save = await SharedPreferences.getInstance();
    return _save.setString(key, value);
  }

  Future<bool> remove(String key) async {
    final _remove = await SharedPreferences.getInstance();
    return _remove.remove(key);
  }
}
