import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {

  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({
    super.key,
    required this.totalAmount 
    });


  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  // List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";

  final AddressServices addressServices = AddressServices();

  // final Future<PaymentConfiguration> _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
  // final Future<PaymentConfiguration> _applePayConfigFuture = PaymentConfiguration.fromAsset('applepay.json');



  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }


  @override
  void initState() {
    super.initState();
    // paymentItems.add(PaymentItem(amount: widget.totalAmount,label: 'Total Amount' , status: PaymentItemStatus.final_price));
  }

  // void onApplePayResult(res){
  //   if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
  //     addressServices.saveUserAddress(context: context,address : addressToBeUsed);
  //   }
  //   addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  // }

  // void onGooglePayResult(res){
  //   if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
  //     addressServices.saveUserAddress(context: context,address : addressToBeUsed);
  //   }
  //   addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  // }


  void onOrderResult(){
    if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context,address : addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  }


  void payPressed(String addressFromProvider){
    addressToBeUsed = "";
    bool isForm = flatBuildingController.text.isNotEmpty || 
    pincodeController.text.isNotEmpty || 
    areaController.text.isNotEmpty || 
    cityController.text.isNotEmpty ;

    if(isForm){
      if(_addressFormKey.currentState!.validate()){
        addressToBeUsed = '${flatBuildingController.text},${areaController.text},${cityController.text} - ${pincodeController.text} ';
        onOrderResult();
      }
      else{
        throw Exception('Please Enter all the values!');
      }
    }else if(addressFromProvider.isNotEmpty){
        addressToBeUsed = addressFromProvider;
        onOrderResult();

      }
      else{
        showSnackBar(context, "ERROR");
      }
  }


  @override
  Widget build(BuildContext context) {

    var address = context.watch<UserProvider>().user.address;


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration : const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            )
          ),
          title: const Text("Address"),
        ),
      ),
      body:
      
       SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
              if(address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        border:  Border.all(
                          color: Colors.black12
                        ),
                      ),
                      child: Text(
                        address,
                        style: const  TextStyle(
                          fontSize: 18,

                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child:  Text("OR" , style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
               Form(
                        key: _addressFormKey,
                        child: Container(
                          decoration : const BoxDecoration(
                            shape: BoxShape.rectangle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0 ,right: 10,bottom: 5),
                            child: Column(
                              children: [
                                CustomTextfield(controller: flatBuildingController ,hintText: "Flat , House no , Building",),
                                CustomTextfield(controller: areaController ,hintText: "Area ,Street",) ,
                                CustomTextfield(controller: pincodeController ,hintText: "Pin code",),
                                CustomTextfield(controller: cityController ,hintText: "Town / City",),
                                // FutureBuilder<PaymentConfiguration>(
                                //   future: _googlePayConfigFuture,
                                //   builder: (context, snapshot) => snapshot.hasData
                                //   ? GooglePayButton(
                                //     cornerRadius: 8,
                                //     width: double.infinity,
                                //     height: 50,
                                //     paymentConfiguration: snapshot.data!,
                                //     paymentItems: paymentItems,
                                //     type:  GooglePayButtonType.buy,
                                //     margin: const EdgeInsets.only(top: 15.0),
                                //     onPressed: ()=>payPressed(address),
                                //     onPaymentResult: onGooglePayResult,
                                //     loadingIndicator: const Center(
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   )
                                //   : const SizedBox.shrink()
                                // ),
                                CustomButton(
                                  onTap: ()=>payPressed(address), 
                                  buttonText: "Order now   |   Cash on Delivery ",
    
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
             ],
           ),
         ),
       ),
      
    );
  }
}