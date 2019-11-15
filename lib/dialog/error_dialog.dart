import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ErrorDialog {
  showErrorDialog(BuildContext context, {String title, String errorMessage}) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "Dismiss",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
