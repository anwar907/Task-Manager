import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_repository/src/storage_repository.dart';

class PereferenceHelper implements StorageRepository {
  SharedPreferences? _prefs;

  PereferenceHelper() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    if (_prefs == null) {
      await init();
    }
    await _prefs?.clear();
  }

  @override
  Future<bool> delete(String key) async {
    if (_prefs == null) {
      await init();
    }
    final isDeleted = await _prefs?.remove(key);

    if (isDeleted == null) return false;

    return isDeleted;
  }

  @override
  Future<U?> read<U>(String key) async {
    if (_prefs == null) {
      await init();
    }

    final value = _prefs?.get(key);

    if (value == null) return null;
    return value as U;
  }

  @override
  Future<void> save(String key, value) async {
    if (_prefs == null) {
      await init();
    }
    if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }
}
