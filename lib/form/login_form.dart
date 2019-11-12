import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.0),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
          keyboardType: TextInputType.visiblePassword,
        )
      ],
    );
  }
}
