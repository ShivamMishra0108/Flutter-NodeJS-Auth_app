import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api',
  );

  /* ---------------- SIGNUP ---------------- */
  static Future<Map<String, dynamic>> signup({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
    String? businessName,
    String? businessDetail,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
          'role': role,
          'businessName': businessName ?? '',
          'businessDetail': businessDetail ?? '',
          'state': state,
          'city': city,
          'locality': locality,
        }),
      );

      return _handle(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /* ---------------- SIGNIN ---------------- */
  static Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return _handle(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /* ---------------- FORGOT PASSWORD ---------------- */
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      return _handle(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /* ---------------- VERIFY OTP ---------------- */
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );

      return _handle(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /* ---------------- RESET PASSWORD ---------------- */
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
      );

      return _handle(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /* ---------------- RESPONSE HANDLER ---------------- */
  static Map<String, dynamic> _handle(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {
        'success': true,
        ...data,
      };
    } else {
      return {
        'success': false,
        'message': data['msg'] ?? data['error'] ?? 'Something went wrong',
      };
    }
  }
}