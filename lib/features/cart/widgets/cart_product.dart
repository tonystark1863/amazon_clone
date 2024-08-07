import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    super.key,
    required this.index
    });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final CartServices cartServices = CartServices();


  void increaseQuantity(Product product){
    cartServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product){
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {

    final  productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);

    
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
           child:  Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: Text(
                        "Rs. ${product.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                        maxLines: 2,
                      ),
                    ), 
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Eligible for FREE shipping",
                      ),
                    ),  
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: const Text(
                        "In Stock",
                        style:  TextStyle(
                          color: Colors.teal
                        ),
                        maxLines: 2,
                      ),
                    ),       
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: ()=> decreaseQuantity(product),
                            child: Container(
                              height: 35,
                              width: 32,
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove,size: 10,),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1
                              ),
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(0)
                            ),
                            child: Container(
                              height: 35,
                              width: 32,
                              alignment: Alignment.center,
                              child:  Text("${productCart['quantity']}"),
                            ),
                          ),
                          InkWell(
                            onTap: () => increaseQuantity(product),
                            child: Container(
                              height: 35,
                              width: 32,
                              alignment: Alignment.center,
                              child: const Icon(Icons.add,size: 10,),
                            ),
                          ),
                        ],
                      ) ,
                    )

                  ],
                ),
              ) 
      ],
    );

  }
}