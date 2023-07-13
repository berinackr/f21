import 'package:flutter/material.dart';

class CustomStyles {
  static const Color backgroundColor = Color.fromARGB(255, 155, 174, 209);
  static Color primaryColor = const Color.fromARGB(255, 31, 4, 99);
  static const Color buttonColor = Color.fromARGB(255, 249, 191, 178);
  static late Color fillColor;
  static const Color errorColor = Colors.red;
  static late Color titleColor;
  static late Color forumTextColor;
  void responsiveTheme(bool isDarkMode) {
    // Burada istediğiniz renkleri döndürmek için bir algoritma kullanabilirsiniz
    // Örneğin:
    if (isDarkMode) {
      fillColor = Colors.grey.shade700;
      titleColor = const Color.fromARGB(255, 169, 135, 255);
      forumTextColor = Colors.grey.shade200;
    } else {
      fillColor = Colors.grey.shade200;
      forumTextColor = Colors.grey.shade700;
      titleColor = const Color.fromARGB(255, 31, 4, 99);
    }
  }
}


