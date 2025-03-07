import 'package:e_stocker/screens/add_screens/catogory_screens.dart';
import 'package:e_stocker/screens/add_screens/product_add.dart';
import 'package:e_stocker/screens/main_screens/add_sale.dart';
import 'package:flutter/material.dart';
import 'package:e_stocker/screens/main_screens/account_screen.dart';
import 'package:e_stocker/screens/edit_screeens/editaccount.dart';
import 'package:e_stocker/screens/main_screens/homescreens.dart';
import 'package:e_stocker/screens/main_screens/loginscreen.dart';
import 'package:e_stocker/screens/navbar.dart';
import 'package:e_stocker/screens/main_screens/splashscreen.dart';
import 'routes.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    Routes.splashScreen: (context) => Splashscreen(),
    Routes.homeScreen: (context) => Homescreens(),
    Routes.editAccount: (context) => Editaccount(),
    Routes.accountScreen: (context) => AccountScreen(),
    Routes.bootUpScreen: (context) => Navbar(),
    Routes.createAccount: (context) => Loginscreen(),
    Routes.addSale: (context) => AddSale(),
    Routes.categories: (context) => CategoryScreen(),
    Routes.addproduct: (context) => AddProduct(),
  };
}
