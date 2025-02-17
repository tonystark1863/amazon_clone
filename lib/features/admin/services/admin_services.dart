// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminServices{
  void sellProduct({
    required BuildContext context,
    required String description,
    required String name,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async{

    final userProvider = Provider.of<UserProvider>(context,listen:false);
    try{

      final cloudinary = CloudinaryPublic('dkfrdrjhb', 'w4tmne5j');
      List<String> imageUrls =[];
      for(int i = 0;i<images.length;i++){
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name),);
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(name: name, description: description, quantity: quantity, images: imageUrls, category: category, price: price);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers:{
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' :userProvider.user.token,
        },
        body: product.toJson()
      );

      httpErrorHandle(response: res, context:context, onSuccess: (){
        showSnackBar(context, "Product added successfully!");
        Navigator.pop(context);
      });


      
    }catch(e){
      showSnackBar(context, e.toString());
    }

  }


  Future<List<Product>> fetchAllProducts(BuildContext context) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList = [];
    try{
      http.Response res =  await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        }
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          for(int i = 0;i<jsonDecode(res.body).length;i++){
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;

  }


  void deleteProduct({required BuildContext context , required Product product , required VoidCallback onSuccess})async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res =  await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        },
        body : jsonEncode({
          'id' : product.id,
        })
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: onSuccess
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }    

  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Order> ordersList = [];
    try{
      http.Response res =  await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        }
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          for(int i = 0;i<jsonDecode(res.body).length;i++){
            ordersList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }
    return ordersList;

  }


  void changeOrderStatus({required BuildContext context , required int status , required Order order,required VoidCallback onSuccess})async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res =  await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        },
        body : jsonEncode({
          'id' : order.id,
          'status': order.status
        })
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: onSuccess
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }    

  }

  Future<Map<String,dynamic>> fetchAnalytics(BuildContext context) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try{
      http.Response res =  await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        }
      );
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          var response = jsonDecode(res.body);
          totalEarnings = response['totalEarnings'];
          sales = [
            Sales("Mobiles", response['mobileEarnings']),
            Sales("Essentials", response['essentialsEarnings']),
            Sales("Appliances", response['appliancesEarnings']),
            Sales("Books", response['booksEarnings']),
            Sales("Fashion", response['fashionEarnings']),

          ];
        }
      );


    }catch(e){
      showSnackBar(context, e.toString());
    }
    return {
      'sales' : sales,
      'totalEarnings' : totalEarnings,
    };

  }




}