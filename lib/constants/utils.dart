// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context , String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}


Future<List<File>> pickImages () async{
  List<File> images  = [];
  try{
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if(files != null && files.files.isNotEmpty){
      for(int i = 0;i<files.files.length;i++){
        images.add(File(files.files[i].path!));
      }
    }
    

  }catch(e){
    debugPrint('ImgaePicker exception --->${e.toString()}');
  }
  return images;
}

void logout (BuildContext context) async{
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token','');
      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route)=> false);
      debugPrint("logged out");

    }catch(e){
      showSnackBar(context, "couldn't logout : ${e.toString()}");
    }
}