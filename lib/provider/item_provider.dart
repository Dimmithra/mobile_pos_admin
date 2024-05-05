import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/model/delete_item_responsemodel.dart';
import 'package:mobile_pos_adminpanell/model/get_all_items_model.dart';
import 'package:mobile_pos_adminpanell/model/item_save_response_model.dart';
import 'package:mobile_pos_adminpanell/model/search_data_model.dart';
import 'package:mobile_pos_adminpanell/pages/home_page/home.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos_adminpanell/service/http_connector.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ItemProvider extends ChangeNotifier {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController get getcompanyNameController => companyNameController;

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
  TextEditingController imagePathTextController = TextEditingController();
  TextEditingController get getimagePathTextController =>
      imagePathTextController;

  TextEditingController discountRateController = TextEditingController();
  TextEditingController get getdiscountRateController => discountRateController;

  TextEditingController discountStartDayController = TextEditingController();
  TextEditingController get getdiscountStartDayController =>
      discountStartDayController;

  TextEditingController discountEndDayController = TextEditingController();
  TextEditingController get getdiscountEndDayController =>
      discountEndDayController;

  TextEditingController searchController = TextEditingController();
  TextEditingController get getsearchController => searchController;

  TextEditingController searchItemController = TextEditingController();
  TextEditingController get getsearchItemController => searchItemController;

  Future<void> clearData() async {
    companyNameController.clear();
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
        "company_name": getcompanyNameController.text,
        "itemname": getitemNameController.text,
        "itemdescription": getdiscriptionController.text,
        "quantity": getquantityController.text,
        "unitprice": "${getunitPriceController.text}",
        "manifectdate": getmanifecturedateController.text,
        "expdate": getexpireDateController.text,
        "image_url": getimagePathTextController.text,
        "discount_available": getispromotion,
        "discountrate": "${getdiscountRateController.text}",
        "discountprice": "$discountAmount",
        "new_market_price": "$newSellingPrice",
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
      setloadingAddItemData(false);
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

  //get all item records
  bool loadGetAllItems = false;
  bool get getloadGetAllItems => loadGetAllItems;
  setloadGetAllItems(val) {
    loadGetAllItems = val;
    notifyListeners();
  }

  Future<void> getAllItemsRecords(context) async {
    try {
      setloadGetAllItems(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {"": ""};
      final response = await commonHttp.post(kgetAllItemRecord, data);
      dev.log('$response');
      GetAllitemsRecords temp =
          GetAllitemsRecords.fromJson(jsonDecode(response));
      if (temp.success == "success") {
        setallitemsRecords(temp);
        // commonMessage(context, errorTxt: '${temp.message}').show();
      } else {
        commonMessage(context, errorTxt: '${temp.message}').show();
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadGetAllItems(false);
    }
  }

  GetAllitemsRecords? allitemsRecords;
  GetAllitemsRecords? get getallitemsRecords => allitemsRecords;
  setallitemsRecords(val) {
    allitemsRecords = val;
    notifyListeners();
  }

  Future<void> getSeacrhItemRecord(context) async {
    try {
      setloadGetAllItems(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {"": ""};
      final response = await commonHttp.post(kgetAllItemRecord, data);
      dev.log('$response');
      GetAllitemsRecords temp =
          GetAllitemsRecords.fromJson(jsonDecode(response));
      if (temp.success == "success") {
        setallitemsRecords(temp);
        // commonMessage(context, errorTxt: '${temp.message}').show();
      } else {
        commonMessage(context, errorTxt: '${temp.message}').show();
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadGetAllItems(false);
    }
  }

  //get Item
  Future<void> getSeacrhItemData(context) async {
    try {
      setloadGetAllItems(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "itemname": getsearchController.text,
        "company_name": getsearchController.text,
        "itemcode": getsearchController.text
      };
      final response = await commonHttp.post(kgetAllItemRecord, data);
      dev.log('$response');
      GetAllitemsRecords temp =
          GetAllitemsRecords.fromJson(jsonDecode(response));
      if (temp.success == "success") {
        setallitemsRecords(temp);
        // commonMessage(context, errorTxt: '${temp.message}').show();
      } else {
        commonMessage(context, errorTxt: '${temp.message}').show();
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadGetAllItems(false);
    }
  }

  //Delete Item recored
  Future<void> deleteItemRecord(context, {required String itemcode}) async {
    try {
      setloadDeleteItem(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "itemcode": itemcode,
      };
      dev.log(data.toString());
      final response = await commonHttp.post(kdeleteItem, data);
      dev.log('$response');
      DeleteItemResponseModel temp =
          DeleteItemResponseModel.fromJson(jsonDecode(response));
      if (temp.success == "success") {
        setdeleteItemResponseModelData(temp);
        commonMessage(context,
            errorTxt: '${temp.message}',
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text("Okay"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                },
              )
            ]).show();
      } else {
        commonMessage(context, errorTxt: '${temp.message}').show();
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadDeleteItem(false);
    }
  }

  bool loadDeleteItem = false;
  bool get getloadDeleteItem => loadDeleteItem;
  setloadDeleteItem(val) {
    loadDeleteItem = val;
    notifyListeners();
  }

  DeleteItemResponseModel? deleteItemResponseModelData;
  DeleteItemResponseModel? get getdeleteItemResponseModelData =>
      deleteItemResponseModelData;
  setdeleteItemResponseModelData(val) {
    deleteItemResponseModelData = val;
    notifyListeners();
  }

  //search selected items
  Future<void> searchSelectedItems(
    context, {
    required String itemcode,
    required String itemName,
    required String companyName,
  }) async {
    try {
      setsearchData(true);
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "itemcode": itemcode,
        "itemname": itemName,
        "company_name": companyName,
      };
      print(data.toString());
      dev.log(data.toString());
      final response = await commonHttp.post(kgetItem, data);
      print('$response');
      SearchDataModel temp = SearchDataModel.fromJson(jsonDecode(response));
      if (temp.data != null) {
        setsearchDataModelData(temp);
      } else {
        commonMessage(context, errorTxt: 'No Record Founded').show();
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setsearchData(false);
    }
  }

  bool searchData = false;
  bool get getsearchData => searchData;
  setsearchData(val) {
    searchData = val;
    notifyListeners();
  }

  SearchDataModel? searchDataModelData;
  SearchDataModel? get getsearchDataModelData => searchDataModelData;
  setsearchDataModelData(val) {
    searchDataModelData = val;
    notifyListeners();
  }

  Future<void> clearSearchData() async {
    getsearchItemController.clear();
    setsearchDataModelData(null);
  }
}
