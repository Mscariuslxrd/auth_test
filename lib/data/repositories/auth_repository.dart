import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/app_constants.dart';
import '../models/user_model.dart';

class AuthRepository {
  final String _baseUrl = AppConstants.baseUrl;

  Future<void> login(String email) async {
    final url = Uri.parse('$_baseUrl/login');
    await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'email': email}));
  }

  Future<Map<String, String>> confirmCode(String email, String code) async {
    final url = Uri.parse('$_baseUrl/confirm_code');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'email': email, 'code': code}));
    final data = jsonDecode(response.body);
    return {'jwt': data['jwt'], 'refresh_token': data['refresh_token']};
  }

  Future<Map<String, String>> refreshToken(String refreshToken) async {
    final url = Uri.parse('$_baseUrl/refresh_token');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'token': refreshToken}));
    final data = jsonDecode(response.body);
    return {'jwt': data['jwt'], 'refresh_token': data['refresh_token']};
  }

  Future<UserModel> getUserId(String jwt) async {
    final url = Uri.parse('$_baseUrl/auth');
    final response = await http.get(url, headers: {'Auth': 'Bearer $jwt'});
    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }
} 