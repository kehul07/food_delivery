import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/pages/order.dart';
import 'package:food_delivery/pages/profile.dart';
import 'package:food_delivery/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPageIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomePage homepage;
  late Wallet wallet;
  late Profile profile;
  late Order order;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homepage = HomePage();
    wallet = Wallet();
    profile = Profile();
    order = Order();

    pages = [homepage , order , wallet , profile];

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // For light icons on the status bar
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 65,
        color: Colors.red,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          currentPageIndex = index;
          setState(() {

          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          )
          ,  Icon(
            Icons.wallet_outlined,
            color: Colors.white,
          )
          ,  Icon(
            Icons.person_outline,
            color: Colors.white,
          )
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
