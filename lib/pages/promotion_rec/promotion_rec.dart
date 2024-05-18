import 'package:flutter/material.dart';

import 'package:mobile_pos_adminpanell/provider/promotion_provider.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PrommotionScreen extends StatefulWidget {
  const PrommotionScreen({super.key});

  @override
  State<PrommotionScreen> createState() => _PrommotionScreenState();
}

class _PrommotionScreenState extends State<PrommotionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PromotionProvider>(context, listen: false)
          .getAllPromotionData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      // appBarColor: kAppBarColor,
      title: 'Promotion Screen',
      body: Consumer<PromotionProvider>(
        builder: (context, promotionProvider, child) {
          if (promotionProvider.getloadPromotionData) {
            return const CommonLoader();
          }
          return promotionProvider.getallPromotionModelData!.data!.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      promotionProvider.getallPromotionModelData!.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Colors.lime.shade900,
                                Colors.green.shade50
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.only(top: 30),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.lightGreen.shade900,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${promotionProvider.getallPromotionModelData!.data![index].promotionDate}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 50),
                                        child: Text(
                                          '${promotionProvider.getallPromotionModelData!.data![index].mainTitle}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo.shade800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          '${promotionProvider.getallPromotionModelData!.data![index].subTitle}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          '${promotionProvider.getallPromotionModelData!.data![index].discription}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        commonMessage(context,
                                            btnType: 3,
                                            errorTxt:
                                                "Are Your Sure Delete Seleected Item",
                                            buttons: [
                                              DialogButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  promotionProvider
                                                      .deletePromotionRecordes(
                                                          context,
                                                          promotion_code:
                                                              "${promotionProvider.getallPromotionModelData!.data![index].promotionCode}");
                                                },
                                              ),
                                              DialogButton(
                                                child: Text("No"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ]).show();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.edit,
                                    //     color: Colors.blue,
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  child: Text("NO Promotion recode Founded"),
                );
        },
      ),
    );
  }
}
