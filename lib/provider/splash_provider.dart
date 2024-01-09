import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/pages/login/login.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';

class SplashProvider extends ChangeNotifier {
  bool loadingPageData = false;
  bool get getloadingPageData => loadingPageData;
  setloadingPageData(val) {
    loadingPageData = val;
    notifyListeners();
  }

  Future<void> loadAppData(context) async {
    await InternetConnectionChecker().isInternetAvailable(context);
    try {
      setloadingPageData(true);
      // await InternetConnectionChecker().isInternetAvailable(context);
      // if (InternetConnectionChecker().isInternetAvailable(context) == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
      // } else {}
      // if (true) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return const LoginScreen();
      //       },
      //     ),
      //   );
      // }
    } catch (e) {
      dev.log("$e");
    } finally {
      setloadingPageData(false);
    }
  }
}
