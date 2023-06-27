import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../core/custom_styles.dart';

class BookMarkedPostsScreen extends ConsumerWidget {
  const BookMarkedPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kaydedilenler'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: const Column(
                  children: [
                    Text('Kaydedilenler Ekranı'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
