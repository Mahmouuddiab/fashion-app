import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  void Function()? onPressed;
  String text;
  AppButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide.none,
          ),
          backgroundColor: Colors.black,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}
