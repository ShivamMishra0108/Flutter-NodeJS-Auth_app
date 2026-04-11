import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_provider.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();

  void sendOtp() async {
  final auth = Provider.of<AuthProvider>(context, listen: false);

  if (email.text.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Enter email")));
    return;
  }

  String res = await auth.forgotPassword(email.text.trim());

  print("Response: $res"); // 👈 DEBUG

  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(res)));

  if (res.toLowerCase().contains("success")) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(email: email.text.trim()),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sendOtp,
                child: const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}