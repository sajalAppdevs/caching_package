import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static Future<void> set(String key, dynamic value, {Duration? expireAfter}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expireAfter?.inMilliseconds,
    };
    await prefs.setString(key, jsonEncode(data));
  }

  static Future<T?> get<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;

    final decoded = jsonDecode(raw);
    final int? expiry = decoded['expiry'];
    final int storedAt = decoded['timestamp'];
    final now = DateTime.now().millisecondsSinceEpoch;

    if (expiry != null && now - storedAt > expiry) {
      await prefs.remove(key); // Expired
      return null;
    }

    return decoded['value'];
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
