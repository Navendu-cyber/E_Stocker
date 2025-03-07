import 'package:e_stocker/database/db_functions/category_funct.dart';

String? validateName(String? value, {required String text}) {
  if (value == null || value.trim().isEmpty) {
    return '$text cannot be empty';
  }
  if (value.length < 3) {
    return '$text must be at least 3 characters long';
  }
  if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
    return '$text must contain only letters';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email cannot be empty';
  }
  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
      .hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Phone number cannot be empty';
  }
  if (!RegExp(r"^\d{10}$").hasMatch(value)) {
    return 'Phone number must be 10 digits';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r"(?=.*[A-Z])").hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r"(?=.*[a-z])").hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r"(?=.*\d)").hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r"(?=.*[@$!%*?&])").hasMatch(value)) {
    return 'Password must contain at least one special character (@, \$, !, %, *, ?, &)';
  }
  return null;
}

String? validateShopName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Shop name cannot be empty';
  }
  if (value.length < 3) {
    return 'Shop name must be at least 3 characters long';
  }
  return null;
}

String? validatecategory(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Category name cannot be empty';
  }
  if (value.length < 3) {
    return 'Category name must be at least 3 characters long';
  }
  if (categoryBox.values.any(
    (element) => element.categoryname == value,
  )) {
    return 'Category Already Exist';
  }
  return null;
}

String? validatePositiveNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  final numValue = num.tryParse(value);
  if (numValue == null || numValue <= 0) {
    return 'Enter a valid number greater than 0';
  }
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
    return 'Invalid characters detected';
  }
  return null;
}

String? validatesellprice(String? value, int buyprice) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  final numValue = num.tryParse(value);
  if (numValue == null || numValue <= 0) {
    return 'Enter a valid number greater than 0';
  }
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
    return 'Invalid characters detected';
  }

  int sell = int.parse(value);
  if (sell <= buyprice) {
    return 'Sell price is Low';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Address cannot be empty";
  }
  if (value.length < 5) {
    return "Address must be at least 5 characters long";
  }
  if (!RegExp(r"^[a-zA-Z0-9\s,.-]+$").hasMatch(value)) {
    return "Address contains invalid characters";
  }
  return null;
}
