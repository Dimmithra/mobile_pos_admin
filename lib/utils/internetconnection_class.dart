import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:developer' as dev;
import 'message.dart';

class InternetConnectionChecker {
  // Singleton instance
  static final InternetConnectionChecker _instance =
      InternetConnectionChecker._internal();

  factory InternetConnectionChecker() {
    return _instance;
  }

  InternetConnectionChecker._internal();

  Future<bool> isInternetAvailable(context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      commonMessage(context,
          errorTxt: 'Please check your internet connection',
          btnType: 1,
          buttons: [
            DialogButton(
              child: const Text(
                'Try again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]).show();
      dev.log('network fasle');
      return false; // No internet connection
    } else {
      dev.log('network true');
      return true; // Internet connection available
    }
  }
}
