import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

Future<FilePickerResult?> pickImage() async {
  final image = FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}

//ValidationBuilder classına şifreleri karşılaştırma eklentisi
extension CustomValidationBuilderRepeatPassword on ValidationBuilder {
  repeatPassword(TextEditingController passwd1, TextEditingController passwd2) => add((value) {
        if (passwd1.text != passwd2.text) {
          return 'Şifreler eşleşmiyor!';
        }
        return null;
      });
}
