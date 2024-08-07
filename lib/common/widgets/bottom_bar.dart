import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {

  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  double bottomNavWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];


  void selectMenu(int currPage){
   
    setState(
       ()=>_page = currPage
    );
  }

@override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {

    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [

          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap:()=> selectMenu(0),
              child: Container(
                width: bottomNavWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                    
                  )
                ),
                child: const Icon(Icons.home_outlined), 
              ),
            ),
            label: '',
          ),


          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: ()=>selectMenu(1),
              child: Container(
                width: bottomNavWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                    
                  )
                ),
                child: const Icon(Icons.person_outline_outlined), 
              ),
            ),
            label: '',
          ),


          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: ()=> selectMenu(2),
              child: Container(
                width: bottomNavWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                    
                  )
                ),
                child:  Badge(
                  label: Text("$userCartLen"),
                  child: const  Icon(Icons.shopping_cart)), 
              ),
            ),
            label: '',
          )


        ],
      ),

    );
  }
}