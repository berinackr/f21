import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomBarRoutingProvider = ChangeNotifierProvider((ref) => BottomBarRoutingRepository());

class BottomBarRoutingRepository extends ChangeNotifier{
  int selectedIndex = 1;

  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }
}