import 'package:flutter/material.dart';

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
}
