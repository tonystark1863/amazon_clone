// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices{

  void addToCart({ required BuildContext context, required Product product})async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
        })
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          User user = userProvider.user.copyWith(
            cart : jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromModel(user);
        }
      );


    }catch(e){
      showSnackBar(context,"add to Cart Error : ${e.toString()}");
    }
  }

  void removeFromCart({ required BuildContext context, required Product product})async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token
        },
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          User user = userProvider.user.copyWith(
            cart : jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromModel(user);
        }
      );


    }catch(e){
      showSnackBar(context,"add to Cart Error : ${e.toString()}");
    }
  }
  

}