import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsRepository());

class SettingsRepository extends ChangeNotifier {
  bool darkMode = false;
  bool silentMode = false;

  void toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    darkMode = !darkMode;
    notifyListeners();
    prefs.setBool('isDarkModeSelected', darkMode);
  }

  bool isDarkMode() {
    return darkMode;
  }

  //şuanki varsayılan olan değeri belirlemek için
  void setDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  void toggleSilentMode() async {
    final prefs = await SharedPreferences.getInstance();
    silentMode = !silentMode;
    notifyListeners();
    prefs.setBool('isSilentModeSelected', silentMode);
  }

  bool isSilentMode() {
    return silentMode;
  }

  //şuanki varsayılan olan değeri belirlemek için
  void setSilentMode(bool value) {
    silentMode = value;
    notifyListeners();
  }
}

//anasayfada da dark mode aç kapa özelliği olacağından kod tekrarı olmasın diye ekledim yukarıdaki toggleDarkmode isimli fonksiyon ile aynı değil!
void toggleDarkMode(WidgetRef ref) {
  ref.read(settingsProvider.notifier).toggleDarkMode();
}

//Uygulamanın herhangi bir yerinden değiştirmek için
void toggleSilentMode(WidgetRef ref) {
  ref.read(settingsProvider.notifier).toggleSilentMode();
}

//Uygulama tercihlerini kontrol eder. SilentMod ve DarkMode'u uygulama açıldığında check eder.
void checkDefaultUIMode(WidgetRef ref) async {
  //Kullanıcının seçtiği son UI modunu hatırlamak için.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? isDarkModeSelected = prefs.getBool('isDarkModeSelected');
  final bool? isSilentModeSelected = prefs.getBool('isSilentModeSelected');

  //DarkMode kontrolcüsü
  if (isDarkModeSelected == null) {
    //demek ki henüz ayarlanmamış false ayarlıyoruz başlangıçta yani kapalı geliyor
    await prefs.setBool('isDarkModeSelected', false);
  } else {
    //eğer ull değilse demek ki kullanıcı daha önceden seçmiş. Seçtiği değeri şuanki dark mode değerine atıyoruz.
    bool? value = prefs.getBool('isDarkModeSelected')!;
    ref.read(settingsProvider.notifier).setDarkMode(value);
  }

  //SilentMode kontrolocüsü
  //DarkMode kontrolcüsü
  if (isSilentModeSelected == null) {
    //demek ki henüz ayarlanmamış false ayarlıyoruz başlangıçta yani kapalı geliyor
    await prefs.setBool('isSilentModeSelected', false);
  } else {
    //eğer null değilse demek ki kullanıcı daha önceden seçmiş. Seçtiği değeri şuanki dark mode değerine atıyoruz.
    bool? value = prefs.getBool('isSilentModeSelected')!;
    ref.read(settingsProvider.notifier).setSilentMode(value);
  }
}
