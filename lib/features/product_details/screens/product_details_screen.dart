import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  final Product productDetails;
  const ProductDetailsScreen({
    super.key,
    required this.productDetails
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {

  final ProductDetailsServices productDetailsServices = ProductDetailsServices();

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for(int i = 0;i<widget.productDetails.rating!.length;i++){
      totalRating += widget.productDetails.rating![i].rating;
      if(widget.productDetails.rating![i].userId == Provider.of<UserProvider>(context,listen: false).user.id){
        myRating = widget.productDetails.rating![i].rating;
      }
    }
    if(totalRating!=0){
      avgRating = totalRating/widget.productDetails.rating!.length;
    }
  }

  void addToCart()async{
    productDetailsServices.addToCart(context: context, product: widget.productDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), 
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ) ,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding:  EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size:23 ,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(color: Colors.black38,width: 1)
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        )
                      ),
                    ),

                  )
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin:  const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic,color: Colors.black,),
              )

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.productDetails.id!),
                   Stars(rating: avgRating)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Text(
                widget.productDetails.name,
                style:const  TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.productDetails.images.map(
                (i){
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 300,
                      width: double.infinity,
                    )
                  );
                }
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300
              )
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              
              child: RichText(
                text: TextSpan(
                  text : 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text : 'Rs. ${widget.productDetails.price}',
                      style:  TextStyle(
                      fontSize: 22,
                      color: Colors.red[800],
                      fontWeight: FontWeight.w500
                    ),
                   ),
                  ]
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.productDetails.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: CustomButton(onTap: (){}, buttonText: "Buy now"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: CustomButton(
                onTap: addToCart, 
                buttonText: "Add to Cart",
                color:const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                "Rate your product",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RatingBar.builder(
                itemSize: 35,
                minRating: 1,
                direction: Axis.horizontal,
                initialRating: myRating,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context,index)=>const Icon(Icons.star,color: GlobalVariables.secondaryColor),
                onRatingUpdate: (rating){
                  productDetailsServices.rateProduct(context: context, product: widget.productDetails, rating: rating);
              
                } ,
              ),
            ),
            const SizedBox(height: 20)                 

          ],
        ),
      ),
      
    );
  }
}