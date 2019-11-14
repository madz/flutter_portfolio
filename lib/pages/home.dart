import 'package:flutter/material.dart';
import 'package:flutter_examples/auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("HOME"),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Sign out"),
              onPressed: () {
                _auth.signOut();

                // remove stored user loggedin info
                final storage = new FlutterSecureStorage();
                storage.deleteAll();

                //
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
