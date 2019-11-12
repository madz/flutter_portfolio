import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String image;
  final Function onPressed;
  final Color color;
  final double width;
  final double height;
  CustomButton(
      {@required this.image,
      this.onPressed,
      this.color,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(5.0),
      elevation: 1.0,
      child: MaterialButton(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                image,
              ),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
