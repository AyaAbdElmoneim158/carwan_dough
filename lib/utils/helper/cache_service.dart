import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Basic getters
  String? getDataString({required String key}) {
    return _prefs.getString(key);
  }

  bool? getDataBool({required String key}) {
    return _prefs.getBool(key);
  }

  int? getDataInt({required String key}) {
    return _prefs.getInt(key);
  }

  double? getDataDouble({required String key}) {
    return _prefs.getDouble(key);
  }

  // Generic save method
  Future<bool> saveData<T>({
    required String key,
    required T value,
  }) async {
    if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is List) {
      final jsonString = jsonEncode(value.map((item) {
        if (item is Map<String, dynamic>) {
          return item;
        } else if (item.toJson() != null) {
          return item.toJson();
        }
        return item.toString();
      }).toList());
      return await _prefs.setString(key, jsonString);
    } else if (value is Map<String, dynamic>) {
      return await _prefs.setString(key, jsonEncode(value));
    } else {
      return await _prefs.setString(key, value.toString());
    }
  }

  // Generic get method for complex objects
  Future<T?> getData<T>({
    required String key,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    if (T == String) {
      return jsonString as T;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => e as String).toList() as T;
    } else if (fromJson != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => fromJson(json)).toList() as T;
    }
    return null;
  }

  // Clear specific key
  Future<bool> removeData({required String key}) async {
    return await _prefs.remove(key);
  }

  // Clear all cached data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
