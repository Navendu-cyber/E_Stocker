import 'dart:io';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/custom%20functions/image_picker.dart';
import 'package:e_stocker/custom%20functions/randomid.dart';
import 'package:e_stocker/custom%20functions/validations.dart';
import 'package:e_stocker/database/db_functions/category_funct.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _brandNamecontroller = TextEditingController();
  final _productNamecontroller = TextEditingController();
  final _productColorcontroller = TextEditingController();
  final _buypricecontroller = TextEditingController();
  final _sellpricecontroller = TextEditingController();
  final _stockcountcontroller = TextEditingController();
  String? imagepath;
  String? selectedCategory;
  final _formkey = GlobalKey<FormState>();
  String? _scannedBarcode;

  double padding = 10.0;

  @override
  void dispose() {
    _brandNamecontroller.dispose();
    _productNamecontroller.dispose();
    _productColorcontroller.dispose();
    _buypricecontroller.dispose();
    _sellpricecontroller.dispose();
    _stockcountcontroller.dispose();
    super.dispose();
  }

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      String scannedCode = result.rawContent.trim();

      if (scannedCode.isNotEmpty) {
        bool barcodeExists = productbox.values.any(
          (product) => product.barcodeId?.trim() == scannedCode,
        );

        if (barcodeExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('This barcode already exists for another product.')),
          );
        } else {
          setState(() {
            _scannedBarcode = scannedCode;
          });
        }
      } else {
        setState(() => _scannedBarcode = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No barcode detected.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barcode scan failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                scanBarcode();
              },
              icon: Icon(Icons.barcode_reader))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: [
                        InkWell(
                          onLongPress: () {
                            selectingimage();
                          },
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Long press for adding image of the product')));
                          },
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 2),
                              boxShadow: [],
                              image: DecorationImage(
                                image: (imagepath == null)
                                    ? AssetImage('assets/images/addphoto.png')
                                    : FileImage(File(imagepath!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTexfield(
                      validator: (value) {
                        return validateName(text: 'Product Name', value);
                      },
                      padding: padding,
                      controller: _productNamecontroller,
                      hintText: 'Product Name',
                      floating: FloatingLabelBehavior.auto),
                  CustomTexfield(
                      validator: (value) =>
                          validateName(text: 'Brand Name', value),
                      padding: padding,
                      controller: _brandNamecontroller,
                      hintText: 'Brand',
                      floating: FloatingLabelBehavior.auto),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: CustomTexfield(
                            validator: (value) =>
                                validateName(text: 'Color', value),
                            padding: padding,
                            controller: _productColorcontroller,
                            hintText: 'Color',
                            floating: FloatingLabelBehavior.auto),
                      ),
                      Flexible(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          value: selectedCategory,
                          hint: Text(
                            'Select Category',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          items: categoryBox.values.map((value) {
                            return DropdownMenuItem(
                              value: value.idCategory.toString(),
                              child: Text(
                                value.categoryname,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          dropdownColor: Colors.white,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                  CustomTexfield(
                      validator: (value) => validatePositiveNumber(value),
                      keyboardType: TextInputType.number,
                      padding: padding,
                      controller: _stockcountcontroller,
                      hintText: 'Stock Count',
                      floating: FloatingLabelBehavior.auto),
                  Row(
                    children: [
                      Flexible(
                          child: CustomTexfield(
                              validator: (value) =>
                                  validatePositiveNumber(value),
                              keyboardType: TextInputType.number,
                              padding: padding,
                              controller: _buypricecontroller,
                              hintText: 'Buy Price',
                              floating: FloatingLabelBehavior.auto)),
                      Flexible(
                          child: CustomTexfield(
                              validator: (value) => validatesellprice(
                                  value, int.parse(_buypricecontroller.text)),
                              keyboardType: TextInputType.number,
                              padding: padding,
                              controller: _sellpricecontroller,
                              hintText: 'Sell Price',
                              floating: FloatingLabelBehavior.auto))
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!_formkey.currentState!.validate()) return;

          if (imagepath == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Select an image to add the product!')),
            );
            return;
          }

          if (_scannedBarcode != null && _scannedBarcode!.trim().isNotEmpty) {
            bool barcodeExists = productbox.values.any(
              (product) => product.barcodeId?.trim() == _scannedBarcode!.trim(),
            );

            if (barcodeExists) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('This barcode already exists!')),
              );
              return;
            }
          }
          final trimmedBarcode = _scannedBarcode?.trim() ?? '';

          print("Barcode to be saved: '$trimmedBarcode'");

          final product = Product(
            barcodeId: trimmedBarcode,
            productid: randomid(),
            productName: _productNamecontroller.text.trim(),
            brand: _brandNamecontroller.text.trim(),
            color: _productColorcontroller.text.trim(),
            stockcount: int.parse(_stockcountcontroller.text),
            buyprice: int.parse(_buypricecontroller.text),
            sellprice: int.parse(_sellpricecontroller.text),
            category: selectedCategory ?? '',
            imageProduct: imagepath!,
          );

          addproduct(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added successfully!')),
          );

          Navigator.of(context).pop();
        },
        label: Text('Add Product'),
        icon: Icon(Icons.add),
        elevation: 10,
      ),
    );
  }

  Future selectingimage() async {
    imagepath = await pickimage();
    if (imagepath != null) {
      setState(() {
        imagepath = imagepath;
      });
    } else {
      print("No image selected.");
    }
  }
}
