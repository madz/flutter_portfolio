import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:regexed_validator/regexed_validator.dart';

final Auth _auth = Auth();

final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController();

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
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
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _auth.sendForgotPasswordLink(
                            context, _emailController.text);
                      } else {
                        debugPrint("Invalid form");
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
