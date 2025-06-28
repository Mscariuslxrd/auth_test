import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _refreshTokenKey = 'refresh_token';
  static const _accessTokenKey = 'access_token';

  static Future<void> saveTokens(String refreshToken, String accessToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _accessTokenKey);
  }
} 