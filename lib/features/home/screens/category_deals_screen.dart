import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const  routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    super.key,
    required this.category
    });

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {

  List<Product>? products;

  final HomeServices homeServices = HomeServices();


  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async{
    products = await homeServices.fetchCatgeoryProduct(context: context, category:widget.category );
    setState(() {});
  }

  void   navitageToProductDetails({ required BuildContext context, required Product product}){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
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
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
            )
        ),
      ),  
      body:
      (products == null)
      ?const LinearProgressIndicator()
       :Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep shopping for ${widget.category}', style: const TextStyle(fontSize: 20),),

          ),
          SizedBox(
            height: 180,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
              padding: const EdgeInsets.only(left: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4
                ,mainAxisSpacing: 10
              ),

              itemBuilder: (context,index){
                final productData = products![index];
                return   GestureDetector(
                  onTap: ()=>navitageToProductDetails(context: context,product: productData),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12 , 
                              width: 0.5
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(productData.images[0]),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 0,top: 5,right: 15),
                        child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ) ,
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        ],

      ),    
    );
  }
}