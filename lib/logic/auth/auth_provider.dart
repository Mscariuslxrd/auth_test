import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';
import '../../service/secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  UserModel? _user;
  String? _jwt;
  String? _refreshToken;

  UserModel? get user => _user;
  String? get jwt => _jwt;
  String? get refreshToken => _refreshToken;

  Future<String?> sendCode(String email) async {
    try {
      await _repository.login(email);
      return null;
    } catch (e) {
      return 'Ошибка: ${e.toString()}';
    }
  }

  Future<String?> confirmCode(String email, String code) async {
    try {
      final tokens = await _repository.confirmCode(email, code);
      _jwt = tokens['jwt'];
      _refreshToken = tokens['refresh_token'];
      await SecureStorage.saveTokens(_refreshToken!, _jwt!);
      return null;
    } catch (e) {
      return 'Ошибка: ${e.toString()}';
    }
  }

  Future<Map<String, String?>> getUserId() async {
    _jwt ??= await SecureStorage.getAccessToken();
    if (_jwt == null) {
      return {'user_id': null, 'error': 'No token'};
    }
    try {
      _user = await _repository.getUserId(_jwt!);
      return {'user_id': _user?.userId, 'error': null};
    } catch (e) {
      return {'user_id': null, 'error': 'Error: ${e.toString()}'};
    }
  }

  Future<void> logout() async {
    _user = null;
    _jwt = null;
    _refreshToken = null;
    await SecureStorage.clearTokens();
    notifyListeners();
  }
} 