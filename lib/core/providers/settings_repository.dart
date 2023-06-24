import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsRepository());

class SettingsRepository extends ChangeNotifier{
  bool darkMode = false;

  void toggleDarkMode() async{
    darkMode = !darkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkModeSelected', darkMode);
  }

  bool isDarkMode(){
    return darkMode;
  }

  void setDarkMode(bool value){
    darkMode = value;
    notifyListeners();
  }
}


  //anasayfada da dark mode aç kapa özelliği olacağından kod tekrarı olmasın diye ekledim yukarıdaki toggleDarkmode isimli fonksiyon ile aynı değil!
  void toggleDarkMode(WidgetRef ref){
    ref.read(settingsProvider.notifier).toggleDarkMode();
  }

  void checkDefaultUIMode(WidgetRef ref) async{
    //Kullanıcının seçtiği son UI modunu hatırlamak için.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isDarkModeSelected = prefs.getBool('isDarkModeSelected');
    if(isDarkModeSelected == null){ //demek ki henüz ayarlanmamış false ayarlıyoruz başlangıçta yani kapalı geliyor
      await prefs.setBool('isDarkModeSelected', false);
    }else{
      //eğer ull değilse demek ki kullanıcı daha önceden seçmiş. Seçtiği değeri şuanki dark mode değerine atıyoruz.
      bool? value = prefs.getBool('isDarkModeSelected')!;
      ref.read(settingsProvider.notifier).setDarkMode(value);
    }
  }