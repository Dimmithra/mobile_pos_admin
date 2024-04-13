import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_searchable.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddNewOffercePage extends StatefulWidget {
  const AddNewOffercePage({super.key});

  @override
  State<AddNewOffercePage> createState() => _AddNewOffercePageState();
}

class _AddNewOffercePageState extends State<AddNewOffercePage> {
  void initState() {
    InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemProvider>(context, listen: false)
          .getAllItemsRecords(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: 'Add New offers',
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          if (itemProvider.getloadingAddItemData) {
            const CommonLoader();
          }
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonInput(
                    hintText: 'Company name',
                    label: 'Company name',
                    fullboader: true,
                    controller: itemProvider.getsearchController,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemProvider.getallitemsRecords!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 16, 43),
                            ),
                          ),
                          child: ListTile(
                            tileColor: kBackgroundColor,
                            // leading: Icon(Icons.notifications_sharp),
                            title: Text(
                              '${itemProvider.getallitemsRecords!.data![index].companyName}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 0, 16, 43)),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${itemProvider.getallitemsRecords!.data![index].itemname}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 29, 80)),
                                ),
                                Text(
                                  '${itemProvider.getallitemsRecords!.data![index].discountAvailable == false ? 'No Discount Available' : 'Discount Available'}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                itemProvider.getallitemsRecords!.data![index]
                                            .discountAvailable ==
                                        true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dis Rate: ${itemProvider.getallitemsRecords!.data![index].discountrate}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 34, 38, 255)),
                                          ),
                                          Text(
                                            '${itemProvider.getallitemsRecords!.data![index].dicountIssuDate} To ${itemProvider.getallitemsRecords!.data![index].dicountExpiredDate}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 85, 87, 255)),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
