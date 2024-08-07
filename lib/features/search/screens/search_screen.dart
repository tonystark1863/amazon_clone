import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery
    });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();

  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchSearchedItems();
  }

  fetchSearchedItems()async{
    products = await searchServices.fetchSearchedItems(context: context,searchItem: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void   navitageToProductDetails({ required BuildContext context, required Product product}){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body : (products == null )
      ?const LinearProgressIndicator()
       :Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context,index){
                final productData = products![index];
                return GestureDetector(
                  onTap: ()=>navitageToProductDetails(context: context,product: productData),
                  child: SearchedProduct(product: productData)
                );

              }
            )
          )
        ]
      ),
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
              // const AddressBox(),
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
              ),
            ],
          ),
        ),
      ),
    );   
  }
}