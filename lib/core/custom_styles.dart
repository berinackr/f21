import 'package:flutter/material.dart';

class CustomStyles {
  static late Color backgroundColor;
  static Color primaryColor = Color(0xffFF8551);
  static const Color buttonColor = Color(0xffFFDEDE);
  static late Color fillColor;
  static const Color errorColor = Colors.red;
  static late Color titleColor;
  static late Color forumTextColor;
  static const Color arkaplan = Color.fromARGB(255, 155, 174, 209);
  static const Color boxColor = Colors.transparent;
  static const Color yaziRengi = Colors.black;

  void responsiveTheme(bool isDarkMode) {
    // Burada istediğiniz renkleri döndürmek için bir algoritma kullanabilirsiniz
    // Örneğin:
    if (isDarkMode) {
      fillColor = Colors.grey.shade700;
      titleColor = Colors.blue;
      forumTextColor = Colors.grey.shade300;
      backgroundColor = Colors.grey.shade700;
    } else {
      fillColor = Colors.grey.shade200;
      forumTextColor = Colors.grey.shade700;
      titleColor = Colors.blue;
      backgroundColor = Colors.grey.shade200;
    }
  }
}
