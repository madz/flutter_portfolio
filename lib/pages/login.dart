import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/form/login_form.dart';
import 'package:flutter_examples/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth auth = Auth();

  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    if (Device.get().isPhone) {
      return _buildMobileLayout(context);
    }
    return _buildTabletLayout(context);
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
                  "Login Now",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Please login or sign up to continue using our app.",
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
                      "Or login with email",
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
                        value: rememberMe,
                        onChanged: (bool newValue) {
                          setState(() {
                            rememberMe = newValue;
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
                              "Login",
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
                      "Don't have account? ",
                    ),
                    InkWell(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        auth.signUp(context);
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

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: SafeArea(),
    );
  }
}
