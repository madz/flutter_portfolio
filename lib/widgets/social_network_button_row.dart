import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/pages/home.dart';
import 'package:flutter_examples/widgets/custom_button.dart';

class SocialNetworkButtonRow extends StatelessWidget {
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomButton(
          image: "images/google.png",
          color: Colors.white,
          height: 60.0,
          width: 120.0,
          onPressed: () async {
            FirebaseUser firebaseUser = await auth.loginGoogle(context);

            if (firebaseUser != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
        ),
        SizedBox(width: 32.0),
        CustomButton(
          image: "images/facebook.ico",
          color: Color(0xff4A6EA9),
          height: 60.0,
          width: 120.0,
          onPressed: () async {
            FirebaseUser firebaseUser = await auth.loginFacebook(context);

            if (firebaseUser != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
