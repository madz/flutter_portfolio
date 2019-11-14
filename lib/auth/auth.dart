import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/dialog/error_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;

class Auth {
  ErrorDialog errorDialog = ErrorDialog();

  Future<AuthResult> signUpEmail(
      BuildContext context, String email, String password) async {
    debugPrint("signUpEmail: email = $email password = $password");
    AuthResult result;
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      PlatformException platformException = e;

      debugPrint('error = ${e.toString()}');
      errorDialog.showErrorDialog(
          context, platformException.message, platformException.details);
    }

    return result;
  }

  Future<FirebaseUser> loginEmail(
      BuildContext context, String email, String password) async {
    debugPrint("loginEmail: email = $email password = $password");

    FirebaseUser user;

    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      PlatformException platformException = e;

      showError(context, platformException);
    }
    return user;
  }

  Future<FirebaseUser> loginGoogle(BuildContext context) async {
    debugPrint("Login Google");
    FirebaseUser user;
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
    } catch (e) {
      PlatformException platformException = e;

      showError(context, platformException);
    }

    return user;
  }

  void loginFacebook() {
    debugPrint("Login Facebook");
  }

  void sendForgotPasswordLink(BuildContext context, String email) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      PlatformException platformException = e;

      debugPrint('error = ${e.toString()}');
      errorDialog.showErrorDialog(
          context, platformException.message, platformException.details);
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  void showError(BuildContext context, PlatformException platformException) {
    debugPrint('error = ${platformException.toString()}');
    errorDialog.showErrorDialog(
        context, platformException.message, platformException.details);
  }
}
