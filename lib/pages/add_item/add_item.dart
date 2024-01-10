import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        backGroundColor: kBackgroundColor,
        title: 'New item add',
        body: SingleChildScrollView(
          child: Consumer(
            builder: (context, value, child) {
              return Center(
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 190,
                          height: 190,
                          child: Image(
                            image: AssetImage('assets/images/addproduct.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:
                              kIsWeb ? 550 : MediaQuery.of(context).size.width,
                          child: CommonInput(
                            hintText: 'Enter item name',
                            label: 'Enter item name',
                            fullboader: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:
                              kIsWeb ? 550 : MediaQuery.of(context).size.width,
                          child: CommonInput(
                            hintText: 'Enter Discription',
                            label: 'Enter Discription',
                            fullboader: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:
                              kIsWeb ? 550 : MediaQuery.of(context).size.width,
                          child: CommonInput(
                            hintText: 'quantity',
                            label: 'quantity',
                            fullboader: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:
                              kIsWeb ? 550 : MediaQuery.of(context).size.width,
                          child: CommonInput(
                            hintText: 'Unit prices',
                            label: 'Unit prices',
                            fullboader: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:
                              kIsWeb ? 550 : MediaQuery.of(context).size.width,
                          child: CommonInput(
                            hintText: 'manifest',
                            label: 'Unit prices',
                            fullboader: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
