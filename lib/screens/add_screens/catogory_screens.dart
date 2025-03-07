import 'package:e_stocker/common%20widgets/showdialog_widget.dart';
import 'package:e_stocker/custom%20functions/randomid.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/categories.dart';
import 'package:e_stocker/database/db_functions/category_funct.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categorycontroller = TextEditingController();
  final _editcontroller = TextEditingController();

  @override
  void dispose() {
    _categorycontroller.dispose();
    _editcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: categoryBox.listenable(),
          builder: (context, Box<Category> box, _) {
            if (box.isEmpty) {
              return Center(
                child: Text(
                  'No Categories Yet',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final categories = box.values.toList();
                  final cat = categories[index];

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        cat.categoryname,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editcontroller.text = cat.categoryname;
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return catogory(
                                    controllerr: _editcontroller,
                                    title: 'Edit Category',
                                    button1: 'Cancel',
                                    button2: 'Save',
                                    hintText: 'Edit Category',
                                    onpress1: () => Navigator.pop(context),
                                    onpress2: () {
                                      var updatedCategory = Category(
                                        categoryname: _editcontroller.text,
                                        idCategory: cat.idCategory,
                                      );
                                      editCAtegory(updatedCategory);
                                      _editcontroller.clear();
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete Category?',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete this category?',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('No',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (productbox.values
                                              .contains(cat.idCategory)) {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'))
                                                    ],
                                                  );
                                                });
                                            return;
                                          }
                                          deleteCategory(
                                              context, cat.idCategory);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return catogory(
                  controllerr: _categorycontroller,
                  title: 'Add Category',
                  button1: 'Cancel',
                  button2: 'Add',
                  hintText: 'Enter Category Name',
                  onpress1: () => Navigator.pop(context),
                  onpress2: () {
                    var categoryName = _categorycontroller.text.trim();

                    var existingCategories = categoryBox.values
                        .map((category) => category.categoryname.toLowerCase())
                        .toList();

                    if (existingCategories
                        .contains(categoryName.toLowerCase())) {
                      _categorycontroller.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          content: Text('Category Already Exists'),
                        ),
                      );
                      return;
                    }

                    var newCategory = Category(
                      categoryname: categoryName,
                      idCategory: randomid(),
                    );

                    addCategory(newCategory);
                    _categorycontroller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Category Added Succesfully'),
                      backgroundColor: Colors.blue,
                    ));
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          icon: Icon(Icons.add),
          label: Text('Add Category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
