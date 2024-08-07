import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/screens/components/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screens/components/orders_screen.dart';
import 'package:amazon_clone/features/admin/screens/components/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {


  final List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),

  ];

  int _page = 0;
  double bottomNavWidth = 42;
  double bottomBarBorderWidth = 5;

  void handleClick(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
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
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon_in.png',width: 120, height: 45, color: Colors.black,),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                  ),
                  )
              )
            ],
          ),
          actions:[
            IconButton(onPressed: ()=> logout(context), icon: const  Icon(Icons.logout_rounded))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        currentIndex: _page,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: ()=> handleClick(0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0 ? GlobalVariables.selectedNavBarColor :  GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth
                    )
                  )
                ),
                width: bottomNavWidth,
                child: const  Icon(Icons.home_outlined),
              ),
            ),
            label: ''
          ),

          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: ()=> handleClick(1),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth
                    )
                  )
                ),
                width: bottomNavWidth,
                child: const  Icon(Icons.analytics_outlined),
              ),
            ),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: ()=> handleClick(2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth
                    )
                  )
                ),
                width: bottomNavWidth,
                child: const  Icon(Icons.all_inbox_outlined),
              ),
            ),
            label: ''
          ),
        ]
      ),
    );
  }
}