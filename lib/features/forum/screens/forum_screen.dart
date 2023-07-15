import 'package:f21_demo/core/categories.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.primaryColor,
        title: const Text('Forum - Kategoriler'),
      ),
      body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Column(
                children: Categories.all
                    .map(
                      (e) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              e.photoPath,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: CustomStyles.titleColor,
                                    ),
                                  ),
                                  Container(height: 10),
                                  Text(
                                    e.description,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: CustomStyles.forumTextColor,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Spacer(),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.transparent,
                                        ),
                                        child: Text(
                                          "KEŞFET",
                                          style: TextStyle(
                                              color: CustomStyles.titleColor),
                                        ),
                                        onPressed: () {
                                          context.push('/forum/${e.id}');
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.transparent,
                                        ),
                                        child: Text(
                                          "SORU SOR",
                                          style: TextStyle(
                                              color: CustomStyles.titleColor),
                                        ),
                                        onPressed: () {
                                          context.push('/forum/${e.id}/share');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList()),
          ),
        );
      })),
    );
  }
}
