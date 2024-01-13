import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/model/item_save_response_model.dart';
import 'package:mobile_pos_adminpanell/pages/home_page/home.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ItemProvider extends ChangeNotifier {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController get getitemNameController => itemNameController;

  TextEditingController discriptionController = TextEditingController();
  TextEditingController get getdiscriptionController => discriptionController;

  TextEditingController quantityController = TextEditingController();
  TextEditingController get getquantityController => quantityController;

  TextEditingController unitPriceController = TextEditingController();
  TextEditingController get getunitPriceController => unitPriceController;

  TextEditingController manifecturedateController = TextEditingController();
  TextEditingController get getmanifecturedateController =>
      manifecturedateController;

  TextEditingController expireDateController = TextEditingController();
  TextEditingController get getexpireDateController => expireDateController;

  TextEditingController discountRateController = TextEditingController();
  TextEditingController get getdiscountRateController => discountRateController;

  TextEditingController discountStartDayController = TextEditingController();
  TextEditingController get getdiscountStartDayController =>
      discountStartDayController;

  TextEditingController discountEndDayController = TextEditingController();
  TextEditingController get getdiscountEndDayController =>
      discountEndDayController;

  Future<void> clearData() async {
    getitemNameController.clear();
    getdiscriptionController.clear();
    getquantityController.clear();
    getunitPriceController.clear();
    getmanifecturedateController.clear();
    getexpireDateController.clear();
    setispromotion(false);
    getdiscountRateController.clear();
    getdiscountStartDayController.clear();
    getdiscountEndDayController.clear();
    discountAmount = '';
    newSellingPrice = '';
  }

  //swich promotion

  bool ispromotion = false;
  bool get getispromotion => ispromotion;
  setispromotion(val) {
    ispromotion = val;
    notifyListeners();
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  //calculatio for new selling price
  String discountAmount = '';
  String newSellingPrice = '';
  void newSellingCalculation(context) async {
    double unitPrice = double.tryParse(getunitPriceController.text) ?? 0;
    double rate = double.tryParse(getdiscountRateController.text) ?? 0;

    //Discount amount
    double calculateDisCountAmount = unitPrice / 100 * rate;
    discountAmount = calculateDisCountAmount.toString();

    // new selling price
    double sellingPrice = unitPrice - calculateDisCountAmount;
    newSellingPrice = sellingPrice.toString();
  }

  bool loadingAddItemData = false;
  bool get getloadingAddItemData => loadingAddItemData;
  setloadingAddItemData(val) {
    loadingAddItemData = val;
    notifyListeners();
  }

  Future<void> addItemData(context) async {
    try {
      setloadingAddItemData(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "itemname": getitemNameController.text,
        "itemdescription": getdiscriptionController.text,
        "quantity": getquantityController.text,
        "unitprice": "LKR ${getunitPriceController.text}",
        "manifectdate": getmanifecturedateController.text,
        "expdate": getexpireDateController.text,
        "discount_available": getispromotion,
        "discountrate": "${getdiscountRateController.text} %",
        "discountprice": "LKR $discountAmount",
        "new_market_price": "LKR $newSellingPrice",
        "dicount_issu_date": discountStartDayController.text,
        "dicount_expired_date": discountEndDayController.text
      };
      dev.log('$data');
      final response = await commonHttp.post(kitemsave, data);
      dev.log('$response');
      ItemSaveRespondeModel temp =
          ItemSaveRespondeModel.fromJson(jsonDecode(response));
      if (temp.success == "Success") {
        commonMessage(context,
            errorTxt: '${temp.message}',
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
              )
            ]).show();
      } else {
        commonMessage(context, errorTxt: "${temp.message}").show();
      }
    } catch (e) {
      dev.log("$e");
    } finally {
      setloadingAddItemData(false);
    }
  }

  ItemSaveRespondeModel? itemSaveRespondeModel;
  ItemSaveRespondeModel? get getItemSaveRespondeModel => itemSaveRespondeModel;
  setitemSaveRespondeModel(val) {
    itemSaveRespondeModel = val;
    notifyListeners();
  }
}
