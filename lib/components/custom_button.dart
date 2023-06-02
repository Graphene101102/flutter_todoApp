import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 115, vertical: 15), backgroundColor: const Color(0xFF57D2C1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
          shadowColor: Colors.grey,
        ),
        child: Text(
          text,
        ));
  }
}
