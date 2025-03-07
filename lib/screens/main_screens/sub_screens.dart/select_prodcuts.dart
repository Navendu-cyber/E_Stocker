import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/selling_products.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/barcodeScreen.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/ordersummary.dart';
import 'package:flutter/material.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/common%20widgets/select_card.dart';
import 'package:flutter/rendering.dart';

ValueNotifier<List<SellingProducts>> selectedProducts = ValueNotifier([]);

class SelectProducts extends StatefulWidget {
  final String customerName;
  final String customerPh;
  final String customerAddress;
  final DateTime dateTime;
  SelectProducts(
      {super.key,
      required this.customerName,
      required this.customerPh,
      required this.customerAddress,
      required this.dateTime});

  @override
  State<SelectProducts> createState() => _SelectProductsState();
}

final TextEditingController search = TextEditingController();
List<Product> filteredProducts = [];
final ScrollController _scrollController = ScrollController();
final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

class _SelectProductsState extends State<SelectProducts> {
  void addToCart(Product product) {
    bool exists = selectedProducts.value
        .any((item) => item.productId == product.productid);

    if (!exists) {
      selectedProducts.value = [
        ...selectedProducts.value,
        SellingProducts(productId: product.productid, productQuantity: 1)
      ];
    }
  }

  void scanBarcode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(onScanned: (barcode) {
          Product? foundProduct = productbox.values.firstWhere(
            (product) => product.barcodeId == barcode,
            orElse: () => Product(
              brand: '',
              category: '',
              color: '',
              buyprice: 0,
              productid: '',
              productName: '',
              stockcount: 0,
              sellprice: 0,
              imageProduct: '',
              barcodeId: '',
            ),
          );
          if (foundProduct.productid.isNotEmpty) {
            bool exists = selectedProducts.value
                .any((element) => element.productId == foundProduct.productid);

            if (!exists) {
              addToCart(foundProduct);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${foundProduct.productName} added to cart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(15),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Product is already in the cart!')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product not found!')),
            );
          }
        }),
      ),
    );
  }

  void removeFromCart(String productId) {
    selectedProducts.value = selectedProducts.value
        .where((item) => item.productId != productId)
        .toList();
  }

  @override
  void initState() {
    filteredProducts = productbox.values.toList();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _isFabVisible.value = false;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _isFabVisible.value = true;
    }
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = productbox.values.toList();
      } else {
        filteredProducts = productbox.values
            .where((product) =>
                product.productName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Products'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                scanBarcode();
              },
              icon: Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
      body: productbox.isEmpty
          ? const Center(child: Text("No Products Available"))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTexfield(
                      onchange: filterProducts,
                      controller: search,
                      hintText: 'Search Product',
                      floating: FloatingLabelBehavior.always),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                            mainAxisExtent: 270),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return SelectCard(
                        id: product.productid,
                        productName: product.productName,
                        stockCount: product.stockcount,
                        productPrice: product.sellprice,
                        imageUrl: product.imageProduct,
                        onAddtoCart: () => addToCart(product),
                        onRemoveFromCart: () =>
                            removeFromCart(product.productid),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _isFabVisible,
        builder: (context, _isVisible, child) => AnimatedOpacity(
          duration: Duration(microseconds: 300),
          opacity: _isVisible ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Ordersummary(
                        dateTime: widget.dateTime,
                        customerName: widget.customerName,
                        customerPh: widget.customerPh,
                        customerAddress: widget.customerAddress,
                      );
                    },
                  ));
                },
                label: Text('Order Summary')),
          ),
        ),
      ),
    );
  }
}
