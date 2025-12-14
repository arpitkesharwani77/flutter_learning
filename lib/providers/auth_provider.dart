import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// USER MODEL
class AppUser {
  final String name;
  final String email;

  AppUser({required this.name, required this.email});
}

/// AUTH PROVIDER (PROFESSIONAL LOCAL AUTH)
class AuthProvider extends ChangeNotifier {
  AppUser? _user;
  bool _isInitialized = false;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isInitialized => _isInitialized;

  /// INIT (called from main)
  Future<void> init() async {
    await _loadUserFromStorage();
    _isInitialized = true;
    notifyListeners();
  }

  // -------------------------
  // SIGNUP
  // -------------------------
  Future<void> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_logged_in', true);

    _user = AppUser(name: name, email: email);
    notifyListeners();
  }

  // -------------------------
  // LOGIN
  // -------------------------
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');
    final savedName = prefs.getString('user_name');

    if (savedEmail == email && savedPassword == password && savedName != null) {
      await prefs.setBool('is_logged_in', true);

      _user = AppUser(name: savedName, email: savedEmail!);
      notifyListeners();
      return true;
    }

    return false;
  }

  // -------------------------
  // LOGOUT (SAFE)
  // -------------------------
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    /// ❗ USER DATA DELETE NAHI KARTE
    await prefs.setBool('is_logged_in', false);

    _user = null;
    notifyListeners();
  }

  // -------------------------
  // LOAD USER
  // -------------------------
  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (!isLoggedIn) return;

    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');

    if (name != null && email != null) {
      _user = AppUser(name: name, email: email);
    }
  }
}
