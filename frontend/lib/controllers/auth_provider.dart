import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  String? token;

  bool isLoading = false;

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

  Future<String> signup(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    String res = await AuthController.signup(data);

    isLoading = false;
    notifyListeners();

    return res;
  }

  Future<String> forgotPassword(String email) async {
    return await AuthController.forgotPassword(email);
  }

  Future<String> verifyOtp(String email, String otp) async {
    return await AuthController.verifyOtp(email, otp);
  }

  Future<String> resetPassword(String email, String newPassword) async {
    return await AuthController.resetPassword(email, newPassword);
  }

  void logout() {
    user = null;
    token = null;
    notifyListeners();
  }

  // SOCIAL LOGIN
    Future<void> socialLogin(User firebaseUser) async {
  isLoading = true;
  notifyListeners();

  final res = await AuthController.socialLogin(firebaseUser);

  user = UserModel.fromJson(res['user']);
  token = res['token'];

  isLoading = false;
  notifyListeners();
}
}