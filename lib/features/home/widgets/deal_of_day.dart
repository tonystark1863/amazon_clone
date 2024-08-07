import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {

  Product? dealOfTheDayProduct;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay()async{
    dealOfTheDayProduct = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToProductDetailsScreen(){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: dealOfTheDayProduct);
  }


  @override
  Widget build(BuildContext context) {
    return dealOfTheDayProduct == null
    ? const Center(child: CircularProgressIndicator())
    : dealOfTheDayProduct!.name.isEmpty ? const SizedBox()
    : GestureDetector(
      onTap: navigateToProductDetailsScreen,
      child: Column(
        children: [
      
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10,top: 15),
            child: const Text(
              "Deal of the Day",
              style: TextStyle(
                fontSize: 20,
      
              ),
            ),
          ),
      
      
          Image.network(
            dealOfTheDayProduct!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child:  Text(
              "Rs. ${dealOfTheDayProduct!.price}" ,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),     
      
      
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15,top: 5,right: 40),
            child:  Text(dealOfTheDayProduct!.name ,maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
      
      
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dealOfTheDayProduct!.images.map((e) =>
                Image.network(e ,fit: BoxFit.contain,height: 150,),
              ).toList()
            ),
          ),
      
          Container(
            padding: const EdgeInsets.only(top: 15,left: 15,bottom: 15),
            alignment: Alignment.topLeft,
            child: Text(
              "See All Details",
              style:  TextStyle(
                color: Colors.cyan[800],
      
              ),
            ),
          )
        ],
      ),
    );
  }
}