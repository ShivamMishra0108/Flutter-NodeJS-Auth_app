import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final role = TextEditingController();
  final businessName = TextEditingController();
  final businessDetail = TextEditingController();
  final stateCtrl = TextEditingController();
  final city = TextEditingController();
  final locality = TextEditingController();

  bool obscure = true;

  void signupUser() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (username.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill required fields")),
      );
      return;
    }

    final data = {
      "username": username.text.trim(),
      "email": email.text.trim(),
      "phone": phone.text.trim(),
      "password": password.text.trim(),
      "role": role.text.trim(),
      "businessName": businessName.text.trim(),
      "businessDetail": businessDetail.text.trim(),
      "state": stateCtrl.text.trim(),
      "city": city.text.trim(),
      "locality": locality.text.trim(),
    };

    String res = await auth.signup(data);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res)));

    if (res == "Success") {
      Navigator.pop(context);
    }
  }

  Widget inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscure : false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => obscure = !obscure),
                )
              : null,
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                inputField(
                    hint: "Username",
                    icon: Icons.person,
                    controller: username),

                inputField(
                    hint: "Email",
                    icon: Icons.email,
                    controller: email),

                inputField(
                    hint: "Phone",
                    icon: Icons.phone,
                    controller: phone),

                inputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    isPassword: true),

                inputField(
                    hint: "Role",
                    icon: Icons.person_outline,
                    controller: role),

                inputField(
                    hint: "Business Name",
                    icon: Icons.business,
                    controller: businessName),

                inputField(
                    hint: "Business Detail",
                    icon: Icons.description,
                    controller: businessDetail),

                inputField(
                    hint: "State",
                    icon: Icons.map,
                    controller: stateCtrl),

                inputField(
                    hint: "City",
                    icon: Icons.location_city,
                    controller: city),

                inputField(
                    hint: "Locality",
                    icon: Icons.home,
                    controller: locality),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : signupUser,
                    child: auth.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white)
                        : const Text("Sign Up"),
                  ),
                ),

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}