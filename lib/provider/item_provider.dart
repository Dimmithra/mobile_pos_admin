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

  Future<void> clearData() async {
    getitemNameController.clear();
    getdiscriptionController.clear();
    getquantityController.clear();
    getunitPriceController.clear();
    getmanifecturedateController.clear();
    getexpireDateController.clear();
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
        "unitprice": getunitPriceController.text,
        "manifectdate": getmanifecturedateController.text,
        "expdate": getexpireDateController.text,
      };
      final response = await commonHttp.post(kitemsave, data);
      dev.log('$response');
      ItemSaveRespondeModel temp =
          ItemSaveRespondeModel.fromJson(jsonDecode(response));
      if (temp.status == "Success") {
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
