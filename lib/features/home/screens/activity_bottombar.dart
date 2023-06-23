import 'package:flutter/material.dart';

class ActivityScreenBottombar extends StatefulWidget {
  const ActivityScreenBottombar({super.key});

  @override
  State<ActivityScreenBottombar> createState() => _ActivityScreenBottombarState();
}

class _ActivityScreenBottombarState extends State<ActivityScreenBottombar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Text("activityscreen")
            ],
          ),
        ),
      );
    },
    );
  }
}
