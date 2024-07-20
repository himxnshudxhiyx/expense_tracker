import 'dart:convert';

import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyAuthToken = 'authToken';
  static const _keyLoginData = 'loginData';

  // Save Auth Token
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthToken, token);
  }
  // Save User Data
  Future<void> saveUserData(UserDetails userDetails) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLoginData, jsonEncode(userDetails));
  }

  // Get Auth Token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken);
  }

  // Get User Data
  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString(_keyLoginData);
    return userData;
  }

  // Remove Auth Token
  Future<void> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAuthToken);
  }

  // Clear all saved data
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}