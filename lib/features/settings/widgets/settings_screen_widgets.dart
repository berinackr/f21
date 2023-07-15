import 'package:flutter/material.dart';

import '../../../core/custom_styles.dart';

class SettingsScreenTitle extends StatelessWidget {
  final String title;
  const SettingsScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}
