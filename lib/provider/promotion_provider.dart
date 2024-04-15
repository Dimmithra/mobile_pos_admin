import 'package:flutter/cupertino.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';

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

  //Save Promotion Data

  bool loadingCreateData = false;
  bool get getloadingAddItemData => loadingCreateData;
  setloadingCreateData(val) {
    loadingCreateData = val;
    notifyListeners();
  }

  Future<void> CreateNewPromotion(context) async {
    try {
      setloadingCreateData(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "main_title": promotionHeadLineController.text,
        "sub_title": promotionSubTitleController.text,
        "discription": promotionDiscriptionController.text,
        "promotion_date": promotionDateController.text,
        "other_comment": "",
      };
    } catch (e) {
      dev.log("$e");
    }
  }
}
