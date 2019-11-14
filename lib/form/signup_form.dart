import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_examples/pages/home.dart';
import 'package:regexed_validator/regexed_validator.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final Auth auth = Auth();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool privacyPolicy = true;

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
                  onTap: () {},
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
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: !privacyPolicy
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                AuthResult result = await auth.signUpEmail(
                                    context,
                                    _emailController.text,
                                    _passwordController.text);

                                if (result != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
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
