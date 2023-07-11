import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final connectionCheckerProvider = ChangeNotifierProvider((ref) => ConnectionCheckerRepository());

class ConnectionCheckerRepository extends ChangeNotifier{

  bool isDeviceConnected = false;

  void checkConnection() async {
    StreamSubscription<ConnectivityResult> subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result != ConnectivityResult.none) {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
      }
    });
    notifyListeners();
  }
}