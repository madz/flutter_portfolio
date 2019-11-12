import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/form/login_form.dart';
import 'package:flutter_examples/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Auth auth = Auth();

  bool privacyPolicy = true;

  @override
  Widget build(BuildContext context) {
    return _buildMobileLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Please sign up to enter our app.",
                ),
                SizedBox(height: 64.0),
                Text(
                  "Enter via social networks",
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      image: "images/twitter.png",
                      color: Color(0xff5AAAF4),
                      height: 60.0,
                      width: 120.0,
                      onPressed: () {
                        auth.loginTwitter();
                      },
                    ),
                    SizedBox(width: 32.0),
                    CustomButton(
                      image: "images/facebook.ico",
                      color: Color(0xff4A6EA9),
                      height: 60.0,
                      width: 120.0,
                      onPressed: () {
                        auth.loginFacebook();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Or sign up with email",
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: LoginForm(),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: privacyPolicy,
                        onChanged: (bool newValue) {
                          setState(() {
                            privacyPolicy = newValue;
                          });
                        },
                      ),
                      Text(
                        "I agree with privacy ",
                        style: TextStyle(),
                      ),
                      InkWell(
                        child: Text(
                          "policy",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          auth.signUp(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 60.0,
                          child: RaisedButton(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              auth.loginEmail(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                    ),
                    InkWell(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        auth.loginEmail(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
