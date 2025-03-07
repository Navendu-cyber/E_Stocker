import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const SETTING_BOX = 'theme_box';

class ThemeSwitching {
  static ValueNotifier<bool> isDArkmode = ValueNotifier(false);

  static Future<void> loadTheme() async {
    var box = await Hive.openBox(SETTING_BOX);
    bool isDark = box.get('isDark', defaultValue: false);
    isDArkmode.value = isDark;
  }

  static Future<void> toggleTheme() async {
    isDArkmode.value = !isDArkmode.value;
    var box = await Hive.openBox(SETTING_BOX);
    await box.put('isDark', isDArkmode.value);
  }
}
