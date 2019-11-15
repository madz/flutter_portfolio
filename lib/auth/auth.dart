import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/dialog/error_dialog.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
      errorDialog.showErrorDialog(context,
          errorMessage: platformException.message,
          title: platformException.code);
    }

    return result;
  }

  Future<FirebaseUser> loginEmail(
      BuildContext context, String email, String password) async {
    debugPrint("loginEmail: email = $email password = $password");
    AuthCredential authCredential = EmailAuthProvider.getCredential(
      email: email,
      password: password,
    );
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
      user.linkWithCredential(credential);
    } catch (e) {
      PlatformException platformException = e;

      showError(context, platformException);
    }

    return user;
  }

  Future<FirebaseUser> loginFacebook(BuildContext context) async {
    debugPrint("Login Facebook");

    FirebaseUser user;

    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);

          user = (await _auth.signInWithCredential(credential)).user;
          user.linkWithCredential(credential);
        } catch (e) {
          PlatformException platformException = e;

          showError(context, platformException);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        showFacebookError(
            context, result.errorMessage, result.status.toString());
        break;
      case FacebookLoginStatus.error:
        showFacebookError(
            context, result.errorMessage, result.status.toString());
        break;
    }

    return user;
  }

  void sendForgotPasswordLink(BuildContext context, String email) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      PlatformException platformException = e;

      debugPrint('error = ${e.toString()}');
      errorDialog.showErrorDialog(context,
          errorMessage: platformException.message,
          title: platformException.code);
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
    errorDialog.showErrorDialog(context,
        errorMessage: platformException.message, title: platformException.code);
  }

  void showFacebookError(
      BuildContext context, String messageError, String errorCode) {
    debugPrint('error = $messageError');
    errorDialog.showErrorDialog(context,
        errorMessage: messageError, title: errorCode);
  }
}
