import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsRepository());

class SettingsRepository extends ChangeNotifier{
  bool darkMode = false;

  void toggleDarkMode(){
    darkMode = !darkMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return darkMode;
  }
}

  void showSnackbarIfDarkModeChanges(WidgetRef ref, BuildContext context){
  final switchValue = ref.watch(settingsProvider).isDarkMode();
  final switchValueChanged = ref.listen(settingsProvider,(previous, next) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            content: Text("Dark mode ${switchValue ? 'kapalı' : 'açık' }."),
          duration: const Duration(seconds: 1),
        )
        );
      },
    );
  }

  //anasayfada da dark mode aç kapa özelliği olacağından kod tekrarı olmasın diye ekledim yukarıdaki toggleDarkmode isimli fonksiyon ile aynı değil!
  void toggleDarkMode(WidgetRef ref){
    ref.read(settingsProvider.notifier).toggleDarkMode();
  }