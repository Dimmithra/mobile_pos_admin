import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_pos_adminpanell/model/login_model.dart';
import 'package:mobile_pos_adminpanell/pages/home_page/home.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/key_constats.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController get getemailController => emailController;

  TextEditingController passwordController = TextEditingController();
  TextEditingController get getpasswordController => passwordController;

  final storage = const FlutterSecureStorage();

  Future<void> clearData(context) async {
    emailController.clear();
    passwordController.clear();
  }

  bool loadingLoginData = false;
  bool get getloadingLoginData => loadingLoginData;
  setloadingLoginData(val) {
    loadingLoginData = val;
    notifyListeners();
  }

  Future<void> loginResponce(context) async {
    try {
      setloadingLoginData(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "email": getemailController.text,
        "password": getpasswordController.text,
      };
      dev.log("$data");
      final response = await commonHttp.post(klogin, data);
      dev.log("$response");
      LoginModel tmp = LoginModel.fromJson(jsonDecode(response));
      if (tmp.success == "success") {
        setloginModal(tmp);
        await storage.write(key: 'kJwtToken', value: '${tmp.token}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ),
        );
      } else {
        commonMessage(context, errorTxt: "${tmp.message}", buttons: [
          DialogButton(
            child: const Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
      }
    } catch (e) {
      dev.log("$e");
    } finally {
      setloadingLoginData(false);
    }
  }

  LoginModel? loginModal;
  LoginModel? get getloginModal => loginModal;
  setloginModal(val) {
    loginModal = val;
    notifyListeners();
  }
}
