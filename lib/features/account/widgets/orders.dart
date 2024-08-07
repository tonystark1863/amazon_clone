import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  
  const Orders({super.key});


  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  final AccountServices accountServices = AccountServices();

  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async{
    orders = await accountServices.getOrdersList(context: context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return orders== null 
    ? const CircularProgressIndicator()
    : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(right:15),
              child:  Text(
                "See All",
                style:  TextStyle(
                  fontSize: 18,
                  color:  GlobalVariables.selectedNavBarColor,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

          ],
        ),


        //orders 

        Container(
          height: 170,
          padding:const EdgeInsets.only(left: 20,top: 20,right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: ()=> Navigator.pushNamed(context,OrderDetailsScreen.routeName,arguments: orders![index]),
                child: SingleProduct(image: orders![index].products[0].images[0])
                );
            },
          ),
        )
      ],
    );
  }
}