import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/model/all_promotion_records.dart';
import 'package:mobile_pos_adminpanell/model/create_promotion_response_model.dart';
import 'package:mobile_pos_adminpanell/model/promotion_create_model.dart';
import 'package:mobile_pos_adminpanell/pages/home_page/home.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class PromotionProvider extends ChangeNotifier {
  DateTime selecteddate = DateTime.now();

  TextEditingController promotionHeadLineController = TextEditingController();
  TextEditingController get getpromotionHeadLineController =>
      promotionHeadLineController;

  TextEditingController promotionSubTitleController = TextEditingController();
  TextEditingController get getpromotionSubTitleController =>
      promotionSubTitleController;

  // TextEditingController promotionCodeeController = TextEditingController();
  // TextEditingController get getpromotionCodeeControllerr =>
  //     promotionCodeeController;

  TextEditingController promotionDiscriptionController =
      TextEditingController();
  TextEditingController get getpromotionDiscriptionController =>
      promotionDiscriptionController;
  TextEditingController promotionDateController = TextEditingController();
  TextEditingController get getpromotionDateController =>
      promotionDateController;

  Future<void> clearPromotionCreateData() async {
    setloadingCreatePromotion(false);
    getpromotionHeadLineController.clear();
    getpromotionSubTitleController.clear();
    // getpromotionCodeeControllerr.clear();
    getpromotionDiscriptionController.clear();
    getpromotionDateController.clear();
  }

  //Save Promotion Data

  bool loadingCreatePromotion = false;
  bool get getloadingCreatePromotion => loadingCreatePromotion;
  setloadingCreatePromotion(val) {
    loadingCreatePromotion = val;
    notifyListeners();
  }

  Future<void> clearData() async {
    promotionHeadLineController.clear();
    promotionSubTitleController.clear();
    promotionDiscriptionController.clear();
    promotionDateController.clear();
    // getpromotionConditionControllerController.clear();
  }

  Future<void> createNewPromotion(context) async {
    try {
      setloadingCreatePromotion(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "main_title": promotionHeadLineController.text,
        "sub_title": promotionSubTitleController.text,
        "discription": promotionDiscriptionController.text,
        "promotion_date": promotionDateController.text,
        // "other_comment": getpromotionDiscriptionController.text,
      };
      dev.log("$data");
      final response = await commonHttp.post(kcreatePromotion, data);
      dev.log('${response}');
      PromotionCreateResponseModel temp =
          PromotionCreateResponseModel.fromJson(jsonDecode(response));
      if (temp.success == "Success") {
        commonMessage(context,
            errorTxt: '${temp.message}',
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ), (route) => false);
                },
              )
            ]).show();
      } else {
        commonMessage(context, errorTxt: "${temp.message}").show();
      }
    } catch (e) {
      dev.log("$e");
      setloadingCreatePromotion(false);
    } finally {
      setloadingCreatePromotion(false);
    }
  }

  CreatePromotionResponseModel? createPromotionResponseModelData;
  CreatePromotionResponseModel? get getcreatePromotionResponseModelData =>
      createPromotionResponseModelData;
  setcreatePromotionResponseModelData(val) {
    createPromotionResponseModelData = val;
    notifyListeners();
  }

  //get all
  Future<void> getAllPromotionData(context) async {
    try {
      setloadPromotionData(true);
      var reqBody = {};
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetAllPromotionRecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      GetAllPromotionModel temp =
          GetAllPromotionModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'success') {
        setallPromotionModelData(temp);
      } else {
        setallPromotionModelData(temp);
        commonMessage(context, errorTxt: "No Promotion Founded").show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadPromotionData(false);
    }
  }

  bool loadPromotionData = false;
  bool get getloadPromotionData => loadPromotionData;
  setloadPromotionData(val) {
    loadPromotionData = val;
    notifyListeners();
  }

  GetAllPromotionModel? allPromotionModelData;
  GetAllPromotionModel? get getallPromotionModelData => allPromotionModelData;
  setallPromotionModelData(val) {
    allPromotionModelData = val;
    notifyListeners();
  }
}
