import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}


class _OrdersScreenState extends State<OrdersScreen> {

  List<Order>? ordersList;

  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    getOrdersList();
  }

  void getOrdersList() async{
    ordersList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return (ordersList == null)
    ? const LinearProgressIndicator()
    :Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recieved orders",
          style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
        ),
      ) ,
      body: GridView.builder(
        itemCount: ordersList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemBuilder: (context,index){
          final orderData = ordersList![index];
          return  GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: orderData);
            },
            child: SizedBox(
              height: 140,
              child: SingleProduct(image: orderData.products[0].images[0]),
            ),
          );
        }
      ),
    );
  }
}