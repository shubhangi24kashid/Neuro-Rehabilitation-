import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5001'; // Emulator localhost
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<bool> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,  // Make sure name is sent
          'email': email,
          'password': password
        }),
      );

      debugPrint("📢 Signup Response: ${response.statusCode}");
      debugPrint("📢 Signup Response Body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint('✅ Signup Successful');
        return true;
      } else {
        debugPrint('❌ Signup Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Signup error: $e');
      return false;
    }
  }

  /// **Login Function**
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('token')) {
          await _storage.write(key: "jwt", value: responseData['token']); // Store token securely
          debugPrint("✅ Login Successful. Token stored.");
          return true;
        }
      }
      debugPrint("❌ Login Failed: ${response.body}");
      return false;
    } catch (e) {
      debugPrint('❌ Login error: $e');
      return false;
    }
  }

  /// **Get Stored JWT Token**
  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: "jwt");
    } catch (e) {
      debugPrint('❌ Error retrieving token: $e');
      return null;
    }
  }

  /// **Logout Function**
  static Future<void> logout() async {
    await _storage.delete(key: "jwt"); // Clear token on logout
    debugPrint("✅ User logged out. Token deleted.");
  }
}
