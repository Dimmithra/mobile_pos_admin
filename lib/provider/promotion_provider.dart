import 'dart:convert';

import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/model/promotion_create_model.dart';
import 'package:mobile_pos_adminpanell/pages/home_page/home.dart';
=======
import 'package:mobile_pos_adminpanell/model/create_promotion_response_model.dart';
>>>>>>> a454dc034cf0a20d0eba67f6a71836dd43a8bcd3
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
<<<<<<< HEAD
import 'package:rflutter_alert/rflutter_alert.dart';
=======
>>>>>>> a454dc034cf0a20d0eba67f6a71836dd43a8bcd3

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

<<<<<<< HEAD
  Future<void> clearPromotionCreateData() async {
    setloadingCreateData(false);
    getpromotionHeadLineController.clear();
    getpromotionSubTitleController.clear();
    // getpromotionCodeeControllerr.clear();
    getpromotionDiscriptionController.clear();
    getpromotionDateController.clear();
  }
=======
  TextEditingController promotionConditionControllerController =
      TextEditingController();
  TextEditingController get getpromotionConditionControllerController =>
      promotionConditionControllerController;
>>>>>>> a454dc034cf0a20d0eba67f6a71836dd43a8bcd3

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
<<<<<<< HEAD
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
      setloadingCreateData(false);
    } finally {
      setloadingCreateData(false);
=======
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
>>>>>>> a454dc034cf0a20d0eba67f6a71836dd43a8bcd3
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
