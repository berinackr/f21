import 'package:flutter/material.dart';

class MyBabyScreenBottombar extends StatefulWidget {
  const MyBabyScreenBottombar({super.key});

  @override
  State<MyBabyScreenBottombar> createState() => _MyBabyScreenBottombarState();
}

class _MyBabyScreenBottombarState extends State<MyBabyScreenBottombar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
          return const SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Text("mybabyscreenbottombar")
                  ],
                ),
              ),
          );
      },
    );
  }
}
