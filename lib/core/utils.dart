import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

//ValidationBuilder classına şifreleri karşılaştırma eklentisi
extension CustomValidationBuilderCheckOldPass on ValidationBuilder {
  checkOldPassword(TextEditingController passwdOld, TextEditingController passwdNew) => add((value) {
    if (passwdOld.text == passwdNew.text) {
      return 'Yeni şifreniz eskisiyle aynı olamaz!';
    }
    return null;
  });
}

String? findAuthExceptionErrorMessage(FirebaseAuthException error){
  String? message;
  switch(error.code){
    case 'too-many-requests':
      message = "Bu cihazdan çok fazla istek aldık. Lütfen daha sonra tekrar deneyin ya da şifrenizi sıfırlayın.";
      break;
    case 'wrong-password':
      message = "Girdiğiniz şifre hatalı. Lütfen tekrar deneyin ya da şifrenizi sıfırlayın.";
      break;
    case 'user-disabled':
      message = "Bu hesap silinmiş ya da banlanmış.";
      break;
    default :
      message = "Şifre güncellenirken bir hata oluştur. Şifrenizi sıfırlamayı deneyin.";
      break;
  }
  return message;
}
