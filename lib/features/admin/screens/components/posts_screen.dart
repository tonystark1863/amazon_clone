import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/components/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  List<Product>? products;

  final AdminServices adminServices = AdminServices();

  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  void  initState(){
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async{
    products = await adminServices.fetchAllProducts(context);
    setState((){});
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
      context: context, 
      product: product, 
      onSuccess: (){
        products!.removeAt(index);
        setState(() {});
      }
    );
    
  }


  @override
  Widget build(BuildContext context) {
    return (products == null) 
    ?const LinearProgressIndicator()
    :Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Products",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        surfaceTintColor: Colors.cyan,
      ),
        body: GridView.builder(
          itemCount: products!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemBuilder: (context,index){
            final productData = products![index];
            return SizedBox(
              child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: productData.images[0]),
                      ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                productData.name , 
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, 
                                style: const  TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            )
                          ),
                          IconButton(
                            onPressed: ()=>deleteProduct(productData, index), 
                            icon: const Icon(Icons.delete))
                        ],
                      ),
                    )
                  ],
                ),
            );
          }
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[600],
        onPressed: navigateToAddProduct,
        tooltip: "Add a Product",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}