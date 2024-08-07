import 'dart:io';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {

  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {



  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();


  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = ['Mobiles' , 'Essentials' , 'Appliances' , 'Books' , 'Fashion'];

  String category = 'Mobiles';

  List<File> images =[];

  final _addProductFormKey = GlobalKey<FormState>();

  void selectImages() async{
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct(){
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty){
      adminServices.sellProduct(
        context: context, 
        description: descriptionController.text, 
        name: productNameController.text, 
        price: double.parse(priceController.text), 
        quantity: double.parse(quantityController.text), 
        category:category,
        images: images
      );
    }

  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15),
            child: Column(
              children: [

                //image pickerr
                const SizedBox(height: 10),
                images.isNotEmpty ? 
                CarouselSlider(
                  items: images.map(
                    (i){
                      return Builder(
                        builder: (BuildContext context) => Image.file(
                          i,
                          fit: BoxFit.cover,
                          height: 200,
                        )
                      );
                    }
                  ).toList(),
                  options: CarouselOptions(viewportFraction: 1,height: 200),
                )
                : GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10,4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open,size: 40),
                          SizedBox(height: 15),
                          Text(
                            "Select Product Images",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                            ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                CustomTextfield(controller: productNameController, hintText: "Product Name"),
                CustomTextfield(controller: descriptionController, hintText: "Description", maxLines: 7),
                CustomTextfield(controller: priceController, hintText: "Price"),
                CustomTextfield(controller: quantityController, hintText: "Quantity"),   

                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    onChanged: (String? newVal)=> {setState(() {
                      category = newVal!;
                    })},
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item){
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item)
                        );
                    }).toList(),
                  ),
                ),   

                // const SizedBox(height: 10),
                CustomButton(onTap: sellProduct, buttonText: "Sell"),    
                const SizedBox(height: 10),   
              ],
            ),
          ),
          
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), 
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ) ,
          centerTitle: true,
          title: const Text("Add Product"),
        ),
      ),      
    );
  }
}