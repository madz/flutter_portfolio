import 'package:flutter/material.dart';
import 'package:flutter_examples/pages/login.dart';
import 'package:flutter_examples/pages/signup.dart';

class Auth {
  void signUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  void loginEmail(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void loginTwitter() {
    debugPrint("Login Twitter");
  }

  void loginFacebook() {
    debugPrint("Login Facebook");
  }
}
