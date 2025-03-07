import 'dart:developer';
import 'package:e_stocker/theme/colorpalette.dart';
import 'package:e_stocker/common%20widgets/custom_button.dart';
import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/custom%20functions/validations.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';

class Editaccount extends StatefulWidget {
  const Editaccount({super.key});

  @override
  State<Editaccount> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Editaccount> {
  final _nameconroller = TextEditingController();
  final _shopname = TextEditingController();
  final _phonenumber = TextEditingController();
  final _gmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedFilePath;
  @override
  void initState() {
    var box = Hive.box<User>(USER_BOX).get('user')!;
    _nameconroller.text = box.name;
    _shopname.text = box.shopname;
    _phonenumber.text = box.phonenumber;
    _gmail.text = box.email;
    selectedFilePath = box.filepaath;
    super.initState();
  }

  @override
  void dispose() {
    _nameconroller.dispose();
    _shopname.dispose();
    _phonenumber.dispose();
    _gmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Account'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
      ),
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
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 60,
                        foregroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: AppColors.textcol,
                          backgroundImage: (selectedFilePath == null)
                              ? AssetImage('assets/images/avatar.png')
                              : FileImage(File(selectedFilePath!)),
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        controller: _nameconroller,
                        hintText: 'Name',
                        keyboardType: TextInputType.name,
                        validator: (value) => validateName(text: 'Name', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Name',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        controller: _shopname,
                        validator: (value) => validateShopName(value),
                        hintText: 'Shopname',
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Shop Name',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        controller: _phonenumber,
                        hintText: 'Phone',
                        validator: (value) => validatePhoneNumber(value),
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Phone',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTexfield(
                        floating: FloatingLabelBehavior.auto,
                        controller: _gmail,
                        hintText: 'email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Gmail',
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      CustomButton1(
                          onpress: () {
                            log(selectedFilePath.toString());
                            _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate()) {
                              var user = User(
                                  name: _nameconroller.text,
                                  shopname: _shopname.text,
                                  phonenumber: _phonenumber.text,
                                  email: _gmail.text,
                                  filepaath: selectedFilePath ??
                                      'assets/images/avatar.png');
                              editUser(user);
                              Navigator.of(context).pop();
                            }
                          },
                          hintTextt: 'Save'),
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
