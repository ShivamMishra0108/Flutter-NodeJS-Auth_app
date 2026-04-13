import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class SocialAuthService {
  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: kIsWeb
            ? "241792538078-thkn93stqan6megsi10qldaoi7meo0u6.apps.googleusercontent.com"
            : null,
      );

      final GoogleSignInAccount? googleUser =
          await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // ✅ Only check accessToken
      if (googleAuth.accessToken == null) {
        throw Exception("Missing Access Token");
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken, 
      );

      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential.user;

    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}