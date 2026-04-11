import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthController {
  static const String baseUrl = "http://localhost:5000/api";

  /* ---------------- SIGNUP ---------------- */
  static Future<String> signup(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 201) {
      return "Success";
    } else {
      return body['msg'] ?? "Error";
    }
  }

  /* ---------------- LOGIN ---------------- */
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/signin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return {
        "token": body['token'],
        "user": UserModel.fromJson(body['user']),
      };
    } else {
      throw Exception(body['msg']);
    }
  }

  /* ---------------- FORGOT PASSWORD ---------------- */
  static Future<String> forgotPassword(String email) async {
  try {
    final res = await http.post(
      Uri.parse("$baseUrl/forgot-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    print("STATUS: ${res.statusCode}");
    print("BODY: ${res.body}");

    final data = jsonDecode(res.body);

    return data['msg'] ?? "No message from server";
  } catch (e) {
    print("ERROR: $e");
    return "Error: $e";
  }
}

  /* ---------------- VERIFY OTP ---------------- */
  static Future<String> verifyOtp(String email, String otp) async {
    final res = await http.post(
      Uri.parse("$baseUrl/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "otp": otp.trim(),
      }),
    );

    final body = jsonDecode(res.body);
    return body['msg'];
  }

  /* ---------------- RESET PASSWORD ---------------- */
  static Future<String> resetPassword(String email, String newPassword) async {
    final res = await http.post(
      Uri.parse("$baseUrl/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "newPassword": newPassword,
      }),
    );

    final body = jsonDecode(res.body);
    return body['msg'];
  }
}