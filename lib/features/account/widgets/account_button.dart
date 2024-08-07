import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;

  const AccountButton({
    super.key,
    required this.title,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal:10),
        height: 40,
        // decoration:  BoxDecoration(
        //   border: Border.all(color: Colors.white,width: 0),
        //   borderRadius: BorderRadius.circular(10),
        //   color: Colors.white
        // ),
        child:  OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor :Colors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            foregroundColor: Colors.cyan,
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ),
    );
  }
}