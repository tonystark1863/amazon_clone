import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopBottons extends StatefulWidget {
  const TopBottons({super.key});

  @override
  State<TopBottons> createState() => _TopBottonsState();
}

class _TopBottonsState extends State<TopBottons> {


  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(title: " Your orders" ,onTap:(){}),
            AccountButton(title: "Turn Seller" ,onTap:(){})
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              title: "Log Out" ,
              onTap:()=> logout(context),
            ),
            AccountButton(title: "Your Wishlist" ,onTap:(){})
          ],
        )
      ],
    );
  }
}