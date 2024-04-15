import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobile_pos_adminpanell/model/create_promotion_response_model.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';

class PromotionProvider extends ChangeNotifier {
  DateTime selecteddate = DateTime.now();

  TextEditingController promotionHeadLineController = TextEditingController();
  TextEditingController get getpromotionHeadLineController =>
      promotionHeadLineController;

  TextEditingController promotionSubTitleController = TextEditingController();
  TextEditingController get getpromotionSubTitleController =>
      promotionSubTitleController;

  TextEditingController promotionCodeeController = TextEditingController();
  TextEditingController get getpromotionCodeeControllerr =>
      promotionCodeeController;

  TextEditingController promotionDiscriptionController =
      TextEditingController();
  TextEditingController get getpromotionDiscriptionController =>
      promotionDiscriptionController;
  TextEditingController promotionDateController = TextEditingController();
  TextEditingController get getpromotionDateController =>
      promotionDateController;

  TextEditingController promotionConditionControllerController =
      TextEditingController();
  TextEditingController get getpromotionConditionControllerController =>
      promotionConditionControllerController;

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
    getpromotionConditionControllerController.clear();
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
        "other_comment": getpromotionConditionControllerController.text,
      };
      dev.log({data}.toString());
      final response = await commonHttp.post(kcreatePromotion, data);
      CreatePromotionResponseModel temp =
          CreatePromotionResponseModel.fromJson(jsonDecode(response));
      if (temp.success == "Success") {
        setcreatePromotionResponseModelData(temp);
        commonMessage(context, errorTxt: "${temp.message}").show();
        await clearData();
      } else {
        commonMessage(context, errorTxt: "${temp.message}").show();
        clearData();
      }
    } catch (e) {
      dev.log("$e");
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
}
