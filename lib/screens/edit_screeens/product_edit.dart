import 'dart:io';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/custom%20functions/image_picker.dart';
import 'package:e_stocker/custom%20functions/validations.dart';
import 'package:e_stocker/database/db_functions/category_funct.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _brandNamecontroller = TextEditingController();
  final _productNamecontroller = TextEditingController();
  final _productColorcontroller = TextEditingController();
  final _buypricecontroller = TextEditingController();
  final _sellpricecontroller = TextEditingController();
  final _stockcountcontroller = TextEditingController();
  String? imagepath;
  String? selectedCategory;
  double padding = 12.0;
  final _formkey = GlobalKey<FormState>();
  String _scannedBarcode = "";
  @override
  void initState() {
    super.initState();
    _brandNamecontroller.text = widget.product.brand;
    _productNamecontroller.text = widget.product.productName;
    _productColorcontroller.text = widget.product.color;
    _buypricecontroller.text = widget.product.buyprice.toString();
    _sellpricecontroller.text = widget.product.sellprice.toString();
    _stockcountcontroller.text = widget.product.stockcount.toString();
    imagepath = widget.product.imageProduct;
    selectedCategory = widget.product.category;
  }

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
      setState(() {
        _scannedBarcode =
            result.rawContent.isEmpty ? "No barcode found" : result.rawContent;
      });
    } catch (e) {
      setState(() {
        _scannedBarcode = "Failed to scan barcode";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        centerTitle: true,
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
                              height: 270,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                image: imagepath != null &&
                                        File(imagepath!).existsSync()
                                    ? DecorationImage(
                                        image: FileImage(File(imagepath!)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: imagepath == null ||
                                      !File(imagepath!).existsSync()
                                  ? Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 60,
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  : null,
                            )),
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
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          items: categoryBox.values.map((value) {
                            return DropdownMenuItem(
                              value: value.idCategory.toString(),
                              child: Text(
                                value.categoryname,
                                style:
                                    TextStyle(fontSize: 16), // Clean text style
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
                              validator: (value) =>
                                  validatePositiveNumber(value),
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
          _formkey.currentState!.validate();
          if (_formkey.currentState!.validate()) {
            if (imagepath == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Select an image to Add Product !')));
              return;
            }

            var product = Product(
                barcodeId: widget.product.barcodeId ?? "Unknown Barcode",
                productid: widget.product.productid,
                productName: _productNamecontroller.text,
                brand: _brandNamecontroller.text,
                color: _productColorcontroller.text,
                stockcount: int.parse(_stockcountcontroller.text),
                buyprice: int.parse(_buypricecontroller.text),
                sellprice: int.parse(_sellpricecontroller.text),
                category: selectedCategory.toString(),
                imageProduct: imagepath ?? '');
            addproduct(product);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        label: Text('Save'),
        icon: Icon(Icons.save_alt),
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
