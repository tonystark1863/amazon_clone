// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices{



  Future<List<Order>> getOrdersList({required BuildContext context}) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Order> productList = [];

    try{
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers:{
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' :userProvider.user.token,
        },

      );

      httpErrorHandle(
        response: res, 
        context:context, 
        onSuccess: (){
          for(int i = 0;i<jsonDecode(res.body).length ;i++){
            productList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i]
                )
              )
            );
          }
        }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;

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


}