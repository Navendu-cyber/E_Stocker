import 'package:e_stocker/common%20widgets/custom_button2.dart';
import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/common%20widgets/history_card.dart';
import 'package:e_stocker/custom%20functions/validations.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_functions/sale_func.dart';
import 'package:e_stocker/database/db_models/sale_model.dart';
import 'package:e_stocker/notification/notification_class.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/select_prodcuts.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddSale extends StatefulWidget {
  AddSale({super.key});

  @override
  State<AddSale> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  TextEditingController customername = TextEditingController();

  TextEditingController customerph = TextEditingController();

  TextEditingController customeraddress = TextEditingController();
  TextEditingController dateTime = TextEditingController();

  DateTime? selectedDate;

  GlobalKey<FormState> validatekey = GlobalKey<FormState>();

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2500));
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateTime.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  final NotificationClass notificationService = NotificationClass();

  Future<void> checkLowStock() async {
    for (var product in productbox.values) {
      if (product.stockcount < 10) {
        await notificationService.showNotification(
          title: "Low Stock Alert",
          body: "${product.productName} has only ${product.stockcount} left!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: saleBox.listenable(),
        builder: (context, Box<SaleModel> box, child) {
          if (box.isEmpty) {
            return Center(
              child: Text('No Sales Here click Add new Sale to add salle'),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final salesHistory = box.getAt(index)!;
              return HistoryCard(
                  saleId: salesHistory.customerName,
                  customerName: salesHistory.customerName,
                  dateTime: salesHistory.dateTime,
                  totalProducts:
                      salesHistory.pruduct_quantity.length.toString(),
                  totalMoney: salesHistory.totalPrice,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure to this Delete sale ? '),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                            TextButton(
                                onPressed: () {
                                  deleteSale(salesHistory.saleid);
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      },
                    );
                  },
                  onPdfDownload: () {},
                  phone: salesHistory.customerPh);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        enableFeedback: true,
        isExtended: true,
        heroTag: false,
        onPressed: () {
          customername.clear();
          customerph.clear();
          customeraddress.clear();
          dateTime.clear();
          showDialog(
            context: context,
            builder: (context) {
              return Form(
                  key: validatekey,
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: 600, minHeight: 500),
                      child: Custom()));
            },
          );
        },
        label: Text('Add new Sale'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget Custom() {
    return AlertDialog(
        title: Text('Enter Customer Details'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CustomTexfield(
                  keyboardType: TextInputType.name,
                  validator: (value) => validateName(value, text: 'Name'),
                  controller: customername,
                  hintText: 'Enter Customer Name',
                  floating: FloatingLabelBehavior.auto),
              SizedBox(height: 20),
              CustomTexfield(
                  validator: (value) => validatePhoneNumber(value),
                  controller: customerph,
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: 'Enter Customer Phone Number',
                  floating: FloatingLabelBehavior.auto),
              SizedBox(
                height: 20,
              ),
              CustomTexfield(
                  controller: customeraddress,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) => validateAddress(value),
                  hintText: 'Enter Customer Address',
                  floating: FloatingLabelBehavior.auto),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: dateTime,
                onTap: () => selectDate(),
                decoration: InputDecoration(
                    labelText: 'Date',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)),
                    prefixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton2(
                text: 'Add',
                onpress: () {
                  if (validatekey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SelectProducts(
                          dateTime: selectedDate == null
                              ? DateTime.now()
                              : selectedDate!,
                          customerName: customername.text,
                          customerPh: customerph.text,
                          customerAddress: customeraddress.text,
                        );
                      },
                    ));
                  }
                  checkLowStock();
                },
                icon: Icon(Icons.add),
              )
            ],
          ),
        ));
  }
}
