import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/pages/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Auth _auth = Auth();
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    userRemember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Center(
          child: Image.asset("images/dropbox.png"),
        ),
      ),
    );
  }

  //login user from remembered email/password credentials.

  void userRemember() async {
    setState(() {
      _showSpinner = true;
    });
    // Create storage
    final storage = new FlutterSecureStorage();
    String email = await storage.read(key: "email");
    String password = await storage.read(key: "password");

    if (email != null && password != null) {
      try {
        FirebaseUser firebaseUser =
            await _auth.loginEmail(context, email, password);
        if (firebaseUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          // remove stored user login info
          final storage = new FlutterSecureStorage();
          storage.deleteAll();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          _showSpinner = false;
        });
      }
    } else {
      setState(() {
        _showSpinner = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}
