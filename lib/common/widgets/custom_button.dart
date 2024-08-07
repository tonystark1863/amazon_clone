import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.color
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: (color==null)?  GlobalVariables.secondaryColor :color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(double.infinity, 50)
        ),
        onPressed: onTap,
        child: Text(buttonText ,style: TextStyle(color: color==null?Colors.white:Colors.black),)
        ),
    );
  }
}