import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemProvider>(context, listen: false).clearData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        backGroundColor: kBackgroundColor,
        title: 'New item add',
        body: SingleChildScrollView(
          child: Consumer<ItemProvider>(
            builder: (context, itemProvider, child) {
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 190,
                              height: 190,
                              child: Image(
                                image:
                                    AssetImage('assets/images/addproduct.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: CommonInput(
                                hintText: 'Enter item name',
                                label: 'Enter item name',
                                fullboader: true,
                                isValidate: true,
                                controller: itemProvider.getitemNameController,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: kIsWeb
                                    ? 550
                                    : MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller:
                                      itemProvider.getdiscriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Discription',
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    label: const Text(
                                      'Enter Discription',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: kCommondarkBlue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: kCommondarkBlue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  minLines:
                                      2, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                )),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: CommonInput(
                                hintText: 'quantity',
                                label: 'quantity',
                                fullboader: true,
                                isValidate: true,
                                controller: itemProvider.getquantityController,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: CommonInput(
                                hintText: 'Unit prices',
                                label: 'Unit prices',
                                fullboader: true,
                                isValidate: true,
                                controller: itemProvider.getunitPriceController,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(1950, 1, 1),
                                    maxTime: DateTime.now()
                                        .add(Duration(days: 365 * 50)),
                                    onChanged: (date) {
                                      // print('change $date');
                                    },
                                    onConfirm: (date) {
                                      itemProvider.getmanifecturedateController
                                              .text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                    },
                                    currentTime: DateTime.now(),
                                  );
                                },
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: CommonInput(
                                    label: 'manufecture date',
                                    hintText: 'manufecture date',
                                    fullboader: true,

                                    // backgroundcolor: kDropBackground,
                                    filled: true,
                                    // bordercolor: kWhiteBorder,
                                    controller: itemProvider
                                        .getmanifecturedateController,
                                    suffix: const Icon(
                                      Icons.calendar_month,
                                      color: kCommonBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(1950, 1, 1),
                                    maxTime: DateTime.now()
                                        .add(Duration(days: 365 * 50)),
                                    onChanged: (date) {
                                      // print('change $date');
                                    },
                                    onConfirm: (date) {
                                      itemProvider
                                              .getexpireDateController.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                    },
                                    currentTime: DateTime.now(),
                                  );
                                },
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: CommonInput(
                                    label: 'Expire date',
                                    hintText: 'Expire date',
                                    fullboader: true,

                                    // backgroundcolor: kDropBackground,
                                    filled: true,
                                    // bordercolor: kWhiteBorder,
                                    controller:
                                        itemProvider.getexpireDateController,
                                    suffix: const Icon(
                                      Icons.calendar_month,
                                      color: kCommonBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: kIsWeb
                                    ? 550
                                    : MediaQuery.of(context).size.width,
                                child: itemProvider.getloadingAddItemData
                                    ? const CommonLoader()
                                    : CommonBtn(
                                        bntName: 'Submite',
                                        onPress: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            itemProvider.addItemData(context);
                                          }
                                        },
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
