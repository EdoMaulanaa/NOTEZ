import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'storage_service.dart';

class AuthService {
  final StorageService _storageService = StorageService();
  final String _usersFile = 'users.json';
  final String _currentUserKey = 'current_user';

  Future<bool> register(String email, String password, String role, {String studentId = ''}) async {
    
    final users = await _getUsers();
    if (users.any((user) => user['email'] == email)) {
      return false;
    }

    
    final user = User(
      email: email,
      password: password,
      role: role,
      studentId: studentId,
    );

    
    await _storageService.appendToJsonList(_usersFile, user.toJson());
    return true;
  }

  Future<bool> login(String email, String password) async {
    
    final users = await _getUsers();
    final userIndex = users.indexWhere(
      (user) => user['email'] == email && user['password'] == password,
    );

    if (userIndex == -1) {
      return false;
    }

    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, json.encode(users[userIndex]));
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_currentUserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    final usersList = await _storageService.readJsonList(_usersFile);
    return List<Map<String, dynamic>>.from(usersList);
  }

  
  Future<void> createDefaultUsers() async {
    if (!await _storageService.fileExists(_usersFile)) {
      await _storageService.writeJsonList(_usersFile, [
        User(
          email: 'student@example.com',
          password: 'password',
          role: 'student',
          studentId: 'S001',
        ).toJson(),
        User(
          email: 'parent@example.com',
          password: 'password',
          role: 'parent',
          studentId: 'S001',
        ).toJson(),
      ]);
    }
  }
} 