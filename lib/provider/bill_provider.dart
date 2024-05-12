import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:mobile_pos_adminpanell/model/bill_recodes_model.dart';
import 'package:mobile_pos_adminpanell/service/url.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';

class BillProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  TextEditingController searchItemController = TextEditingController();
  TextEditingController get getsearchItemController => searchItemController;
  TextEditingController searchTypeController = TextEditingController();
  TextEditingController get getsearchTypeController => searchTypeController;

  Future<void> seachBillRecode(context,
      {required String billNo,
      required String cusEmail,
      required String cusModile}) async {
    setloadBillPaymentRecords(true);
    try {
      var reqBody = {
        "bill_no": billNo,
        "cus_email": cusEmail,
        "cus_mobileno": cusModile,
      };
      print(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetbillRecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      BillRecordsModel temp =
          BillRecordsModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (temp.success == "success") {
        setbillRecordsModelData(temp);

        // setitemData(temp);
      } else {
        commonMessage(context, errorTxt: temp.message.toString()).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadBillPaymentRecords(false);
    }
  }

  bool loadBillPaymentRecords = false;
  bool get getloadBillPaymentRecords => loadBillPaymentRecords;
  setloadBillPaymentRecords(val) {
    loadBillPaymentRecords = val;
    notifyListeners();
  }

  BillRecordsModel? billRecordsModelData;
  BillRecordsModel? get getbillRecordsModelData => billRecordsModelData;
  setbillRecordsModelData(val) {
    billRecordsModelData = val;
    notifyListeners();
  }

  Data? itemData;
  Data? get getitemData => itemData;
  setitemData(val) {
    itemData = val;
    notifyListeners();
  }

  void clearData() async {
    searchItemController.clear();
    setbillRecordsModelData(null);
  }
}
