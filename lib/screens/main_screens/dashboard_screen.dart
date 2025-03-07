import 'package:e_stocker/common%20widgets/cards_stage2.dart';
import 'package:e_stocker/database/db_functions/sale_func.dart';
import 'package:e_stocker/database/db_models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedFilter = 0;

  List<SaleModel> getFilteredSales() {
    DateTime now = DateTime.now();
    DateTime startDate;

    if (selectedFilter == 0) {
      startDate = now.subtract(Duration(days: 7));
    } else if (selectedFilter == 1) {
      startDate = DateTime(now.year, now.month - 1, now.day);
    } else {
      startDate = DateTime(now.year, 1, 1);
    }

    return saleBox.values.where((sale) {
      return sale.dateTime.isAfter(startDate);
    }).toList();
  }

  int calculateProfit() {
    return getFilteredSales().fold(0, (sum, sale) => sum + sale.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: saleBox.listenable(),
            builder: (context, value, child) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      ChoiceChip(
                        label: Text(
                          "Last Week",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedFilter == 0
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        selected: selectedFilter == 0,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = 0;
                          });
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        selectedColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color:
                                selectedFilter == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      ChoiceChip(
                        label: Text(
                          "Last Month",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedFilter == 1
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        selected: selectedFilter == 1,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = 1;
                          });
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        selectedColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color:
                                selectedFilter == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      SizedBox(width: 8),
                      ChoiceChip(
                        label: Text(
                          "This Year",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedFilter == 2
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        selected: selectedFilter == 2,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = 2;
                          });
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        selectedColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color:
                                selectedFilter == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CardsStage2(
                    height: 150.0,
                    width: 350,
                    headText: 'Total Sales',
                    subText: getFilteredSales().length.toString(),
                    cardBackgroundColor: Colors.green,
                  ),
                  CardsStage2(
                    height: 150.0,
                    width: 350,
                    headText: 'Total Profit',
                    subText: '₹${calculateProfit()}',
                    cardBackgroundColor: Colors.green,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
