import 'dart:developer';
import 'dart:io';
import 'package:e_stocker/database/db_functions/sale_func.dart';
import 'package:e_stocker/routes/routes.dart';
import 'package:e_stocker/common%20widgets/custom_cardsbutton.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_models/theme_switching.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/aboutApp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name = 'Unknown';
  String shopname = 'Unknown';
  String phone = 'Unknown';
  String email = 'Unknown';
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ThemeSwitching.toggleTheme();
            },
            icon: ValueListenableBuilder<bool>(
              valueListenable: ThemeSwitching.isDArkmode,
              builder: (context, isDark, child) {
                return Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                    size: 28);
              },
            ),
          ),
        ],
        title: Text(
          'My Account',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: userBox.listenable(),
                  builder: (context, Box<User> box, child) {
                    var user = box.get('user');

                    if (user != null) {
                      name = user.name;
                      shopname = user.shopname;
                      phone = user.phonenumber;
                      email = user.email;
                      image = user.filepaath;
                    }
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: image == null
                                      ? AssetImage('assets/images/avatar.png')
                                          as ImageProvider
                                      : FileImage(File(image!)),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).primaryColorDark,
                                  child: IconButton(
                                    onPressed: () {
                                      log('Midlag');
                                      Navigator.of(context)
                                          .pushNamed(Routes.editAccount);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: ThemeSwitching.isDArkmode.value
                                            ? Colors.white
                                            : Colors.black,
                                        size: 20),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Divider(color: Colors.grey.shade400, thickness: 1),
                            AccountInfoTile(
                                label: 'Name', data: name, icon: Icons.person),
                            AccountInfoTile(
                                label: 'Shop Name',
                                data: shopname,
                                icon: Icons.storefront),
                            AccountInfoTile(
                                label: 'Phone Number',
                                data: phone,
                                icon: Icons.phone),
                            AccountInfoTile(
                                label: 'Email', data: email, icon: Icons.email),
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 15),
              CustomCard(
                text: 'Categories',
                iconc: Icons.category_outlined,
                ontapp: () {
                  Navigator.of(context).pushNamed(Routes.categories);
                },
              ),
              CustomCard(
                text: 'About the App',
                iconc: Icons.phone_android_sharp,
                ontapp: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Aboutapp();
                    },
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountInfoTile extends StatelessWidget {
  final String label;
  final String data;
  final IconData icon;

  const AccountInfoTile(
      {super.key, required this.label, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label: $data',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
