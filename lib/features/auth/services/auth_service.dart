// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  void signupUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async{
    try{
      User user = User(
        id: '', 
        name: name, 
        email: email, 
        password: password, 
        address: '', 
        type: '', 
        token: '',
        cart: []
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8',
        }
      );

      httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: (){
          showSnackBar(context, "Account created ! Login with the same credentails");
      },);

    }catch(e){
      showSnackBar(context, e.toString());
    }
  }


  void signinUser({
    required BuildContext context,
    required String email,
    required String password,
  })async{
    try{

        http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email' : email,
          'password' : password,
        }
          
        ),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8',
        }
      );

      httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context,listen: false).setUser(res.body);
            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context, 
              BottomBar.routeName, 
              (route) =>false,
            );
          }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }
  }



  void getUserData(BuildContext context)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      print(token);

      if(token == null){
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String,String> {
          'Content-Type':'application/json; charset=UTF-8',
          "x-auth-token":token!,
        }
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true){
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String,String> {
          'Content-Type':'application/json; charset=UTF-8',
          "x-auth-token":token,
        }
        );

        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.setUser(userRes.body);
      }

    }
    catch(e){
      showSnackBar(context,e.toString());

    }
  }
}