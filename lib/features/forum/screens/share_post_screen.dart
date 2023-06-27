import 'dart:io';

import 'package:f21_demo/core/categories.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/forum/controller/forum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class SharePostScreen extends ConsumerStatefulWidget {
  const SharePostScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SharePostScreenState();
}

class _SharePostScreenState extends ConsumerState<SharePostScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File? postFile;
  void selectPostImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        postFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final categoryName = Categories.getCategoryNameById(int.parse(widget.id));
    final isLoading = ref.watch(forumControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('$categoryName - Soru Sor'),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  final data = _formKey.currentState!.value;
                  final forumController =
                      ref.read(forumControllerProvider.notifier);
                  forumController.sharePost(
                    title: data['title'],
                    content: data['content'],
                    category: categoryName,
                    categoryId: widget.id,
                    photo: postFile,
                    context: context,
                  );
                  ref.invalidate(postsProvider(widget.id));
                  ref.invalidate(commentsProvider(widget.id));
                }
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: isLoading
                    ? const Loader()
                    : FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Başlık*",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomStyles.titleColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FormBuilderTextField(
                              name: "title",
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: "Annelere bir sorum var",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomStyles.titleColor,
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                fillColor: CustomStyles.fillColor,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: ValidationBuilder(localeName: "tr")
                                  .minLength(3)
                                  .maxLength(144)
                                  .build(),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "İçerik*",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomStyles.titleColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FormBuilderTextField(
                              name: "content",
                              controller: contentController,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "Merhaba anneler, ...",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomStyles.titleColor,
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                fillColor: CustomStyles.fillColor,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: ValidationBuilder(localeName: "tr")
                                  .minLength(3)
                                  .maxLength(500)
                                  .build(),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Fotoğraf",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomStyles.titleColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: selectPostImage,
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CustomStyles.fillColor,
                                  border: Border.all(
                                      color: CustomStyles.titleColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: postFile != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          postFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: CustomStyles.titleColor,
                                      ),
                              ),
                            )
                          ],
                        )),
              ),
            );
          }),
        ));
  }
}
