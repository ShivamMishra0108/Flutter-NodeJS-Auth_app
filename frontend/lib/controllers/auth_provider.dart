import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  String? token;

  bool isLoading = false;

  /* LOGIN */
  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await AuthController.login(email, password);
      user = res['user'];
      token = res['token'];
    } catch (e) {
      rethrow;
    }

    isLoading = false;
    notifyListeners();
  }

  /* SIGNUP */
  Future<String> signup(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    String res = await AuthController.signup(data);

    isLoading = false;
    notifyListeners();

    return res;
  }

  /* FORGOT PASSWORD */
  Future<String> forgotPassword(String email) async {
    return await AuthController.forgotPassword(email);
  }

  /* VERIFY OTP */
  Future<String> verifyOtp(String email, String otp) async {
    return await AuthController.verifyOtp(email, otp);
  }

  /* RESET PASSWORD */
  Future<String> resetPassword(String email, String newPassword) async {
    return await AuthController.resetPassword(email, newPassword);
  }

  void logout() {
    user = null;
    token = null;
    notifyListeners();
  }
}