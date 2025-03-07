import 'package:e_stocker/routes/routes.dart';
import 'package:e_stocker/theme/colorpalette.dart';
import 'package:e_stocker/common%20widgets/custom_button.dart';
import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/custom%20functions/validations.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _nameconroller = TextEditingController();
  final _shopname = TextEditingController();
  final _phonenumber = TextEditingController();
  final _gmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedFilePath;
  @override
  void dispose() {
    _shopname.dispose();
    _phonenumber.dispose();
    _gmail.dispose();
    _nameconroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 90, 0, 40),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create an Account,',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'To continue to E-Stocker you want to create an Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 60,
                        foregroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: AppColors.textcol,
                          backgroundImage: (selectedFilePath != null)
                              ? FileImage(File(selectedFilePath!))
                              : AssetImage('assets/images/avatar.png'),
                          radius: 58,
                          child: IconButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);

                              if (result != null) {
                                setState(() {
                                  selectedFilePath = result.files.single.path;
                                  print('File selected: $selectedFilePath');
                                });
                              } else {
                                print("No file selected");
                              }
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.never,
                        labelText: 'Name',
                        controller: _nameconroller,
                        hintText: 'Enter your Name',
                        keyboardType: TextInputType.name,
                        validator: (value) => validateName(text: 'Name', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        labelText: 'Shop Name',
                        controller: _shopname,
                        validator: (value) => validateShopName(value),
                        hintText: 'Enter your Shop/Company Name',
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        labelText: 'Phone Number',
                        controller: _phonenumber,
                        hintText: 'Enter Your Phone Number',
                        validator: (value) => validatePhoneNumber(value),
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        labelText: 'Email',
                        controller: _gmail,
                        hintText: 'Enter your Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      CustomButton1(
                          onpress: () {
                            _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate()) {
                              var user = User(
                                  name: _nameconroller.text,
                                  shopname: _shopname.text,
                                  phonenumber: _phonenumber.text,
                                  email: _gmail.text,
                                  filepaath: selectedFilePath ?? '');
                              addUser(user);
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.bootUpScreen);
                            }
                          },
                          hintTextt: 'Create'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
