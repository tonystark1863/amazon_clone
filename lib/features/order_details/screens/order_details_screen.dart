import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';

  final Order orderDetails;
  const OrderDetailsScreen({
    super.key,
    required this.orderDetails,
    });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  final AdminServices adminServices = AdminServices();

  int currentStep = 0;

    void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.orderDetails.status;
  }


  void changeOrderStatus(int status){
    adminServices.changeOrderStatus(
      context: context, 
      status: status, 
      order: widget.orderDetails, 
      onSuccess: (){
        setState(() {
          currentStep+=1;
          }
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {

    final user  =Provider.of<UserProvider>(context).user;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5              )
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date : ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.orderDetails.orderedAt))}"
                    ),
                    Text(
                      "Order ID : ${widget.orderDetails.userId}",
                    ),
                    Text(
                      "Order Total: Rs.${widget.orderDetails.totalPrice}"
                    ),
                  ],
                ),
              ),
              const Text(
                "Purchase details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black12
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i  =0;i<widget.orderDetails.products.length;i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          widget.orderDetails.products[i].images[0],
                          height: 120,
                          width: 120,
                          fit: BoxFit.contain,
                          ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.orderDetails.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Text("Qty : ${widget.orderDetails.quantity[i]}")
                              ],
                            ),
                          ),
                        )       
                      ],
                    ),
                  ],
                ),
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,      
                  )
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details){
                    if(user.type == 'admin'){
                      return CustomButton(onTap: ()=> changeOrderStatus(details.currentStep), buttonText: "Done");
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text("Pending") , 
                      content: const Text("Your order is yet to be delivered"),
                      isActive: currentStep>0,
                      state: currentStep>0 ? StepState.complete : StepState.indexed

                    ),
                    Step(
                      title: const Text("Completed") , 
                      content: const Text("Your order has been delivered, you are yet to sign."),
                      isActive: currentStep>1,
                      state: currentStep>1 ? StepState.complete : StepState.indexed
                    ),
                    Step(
                      title: const Text("Recieved") , 
                      content: const Text("Your order has been delivered and signed by you/"),
                      isActive: currentStep>2,
                      state: currentStep>2 ? StepState.complete : StepState.indexed
                    ), 
                    Step(
                      title: const Text("Delivered") , 
                      content: const Text("Your order has been delivered and signed by you!"),
                      isActive: currentStep>=3,
                      state: currentStep>=3 ? StepState.complete : StepState.indexed
                    ),                                        
                  ],
                ),
              )          
                      
            ],
          ),
        ),
      ), 
    );
  }
}