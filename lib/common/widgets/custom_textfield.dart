import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    });

  

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        decoration:  InputDecoration(
          hintText: hintText,
          border:  const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
          ),
          enabledBorder: const  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
      ),
      validator: (val){
        if(val==null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },
      ),
    );
  }
}