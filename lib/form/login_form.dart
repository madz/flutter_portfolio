import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/pages/forgot_password.dart';
import 'package:flutter_examples/pages/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Auth auth = Auth();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              validator: (String value) {
                return !validator.email(_emailController.text)
                    ? 'Email is invalid.'
                    : null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) =>
                  value.isEmpty ? 'Password can\'t be empty' : null,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool newValue) {
                    setState(() {
                      _rememberMe = newValue;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "Remember me ",
                  ),
                ),
                InkWell(
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 60.0,
                    child: RaisedButton(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          FirebaseUser firebaseUser = await auth.loginEmail(
                              context,
                              _emailController.text,
                              _passwordController.text);

                          if (firebaseUser != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );

                            if (_rememberMe) {
                              final storage = new FlutterSecureStorage();
                              //save email and password for remembering user
                              await storage.write(
                                  key: "email", value: _emailController.text);

                              await storage.write(
                                  key: "password",
                                  value: _passwordController.text);
                            }
                          }
                        } else {
                          debugPrint("Invalid form");
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
