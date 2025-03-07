import 'package:e_stocker/screens/main_screens/add_sale.dart';
import 'package:e_stocker/screens/main_screens/product_screen_out.dart';
import 'package:e_stocker/theme/colorpalette.dart';
import 'package:e_stocker/screens/main_screens/account_screen.dart';
import 'package:e_stocker/screens/main_screens/dashboard_screen.dart';
import 'package:e_stocker/screens/main_screens/homescreens.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currenIndex = 0;

  final List<Widget> _screens = [
    Homescreens(),
    Dashboard(),
    AddSale(),
    ProductScreenOut(),
    AccountScreen()
  ];

  Future<bool> _onWillPop() async {
    if (currenIndex != 0) {
      setState(() {
        currenIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: currenIndex,
          children: _screens,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: AppColors.primary,
          ),
          child: BottomNavigationBar(
              onTap: (index) => setState(() {
                    currenIndex = index;
                  }),
              currentIndex: currenIndex,
              unselectedItemColor: AppColors.secondary,
              backgroundColor: Colors.blue,
              elevation: 30.0,
              selectedItemColor: AppColors.lavender,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_box,
                      size: 30,
                    ),
                    label: 'Add Sale'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.pix_rounded), label: 'Products'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.view_module_rounded), label: 'More'),
              ]),
        ),
      ),
    );
  }
}
