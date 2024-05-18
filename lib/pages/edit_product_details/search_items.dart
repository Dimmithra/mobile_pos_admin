import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({super.key});

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemProvider>(context, listen: false).clearSearchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "Search",
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ItemProvider>(
                builder: (context, itemProvider, child) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: CommonInput(
                          fullboader: true,
                          hintText: "Search....",
                          label: "Search....",
                          controller: itemProvider.getsearchItemController,
                          suffix: Icon(Icons.search),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonBtn(
                              bntName: "Search",
                              onPress: () {
                                setState(() {
                                  itemProvider.searchSelectedItems(context,
                                      itemcode: itemProvider
                                          .getsearchItemController.text,
                                      itemName: itemProvider
                                          .getsearchItemController.text,
                                      companyName: itemProvider
                                          .getsearchItemController.text);
                                });
                              },
                            ),
                          )),
                    ],
                  );
                },
              ),
            ),
            Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                return itemProvider.getsearchDataModelData != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: itemProvider.getsearchData
                            ? const CommonLoader()
                            : itemProvider.getsearchDataModelData!.data != null
                                ? ListView.builder(
                                    itemCount: itemProvider
                                        .getsearchDataModelData!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 0, 16, 43),
                                            ),
                                          ),
                                          child: ListTile(
                                            tileColor: kBackgroundColor,
                                            // leading: Icon(Icons.notifications_sharp),
                                            title: Text(
                                              '${itemProvider.getsearchDataModelData!.data![index].companyName}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 0, 16, 43)),
                                            ),
                                            subtitle: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${itemProvider.getsearchDataModelData!.data![index].imageUrl}',
                                                        height: 80,
                                                        width: 80,
                                                        placeholder:
                                                            (context, url) {
                                                          return const CircularProgressIndicator();
                                                        },
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return SizedBox
                                                              .shrink();
                                                        },
                                                        // fadeInDuration:
                                                        //     const Duration(seconds: 3),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${itemProvider.getsearchDataModelData!.data![index].itemname}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      0,
                                                                      29,
                                                                      80)),
                                                        ),
                                                        Text(
                                                          '${itemProvider.getsearchDataModelData!.data![index].discountAvailable == false ? 'No Discount Available' : 'Discount Available'}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        itemProvider
                                                                    .getsearchDataModelData!
                                                                    .data![
                                                                        index]
                                                                    .discountAvailable ==
                                                                true
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Dis Rate: ${itemProvider.getsearchDataModelData!.data![index].discountrate}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            34,
                                                                            38,
                                                                            255)),
                                                                  ),
                                                                  Text(
                                                                    '${itemProvider.getsearchDataModelData!.data![index].dicountIssuDate} To ${itemProvider.getsearchDataModelData!.data![index].dicountExpiredDate}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            85,
                                                                            87,
                                                                            255)),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox.shrink(),
                                                        Text(
                                                            "Discription: ${itemProvider.getsearchDataModelData!.data![index].itemdescription}"),
                                                        Text(
                                                            "Price: ${itemProvider.getsearchDataModelData!.data![index].unitprice}"),
                                                        Text(
                                                            "Manufecture Date: ${itemProvider.getsearchDataModelData!.data![index].manifectdate}"),
                                                        Text(
                                                            "Expire Date: ${itemProvider.getsearchDataModelData!.data![index].expdate!.isNotEmpty ? itemProvider.getsearchDataModelData!.data![index].expdate : ''}")
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: QrImageView(
                                                        data:
                                                            'Company name: ${itemProvider.getallitemsRecords!.data![index].companyName}, Product name: ${itemProvider.getallitemsRecords!.data![index].itemname},Item Code: ${itemProvider.getallitemsRecords!.data![index].itemcode},Selling Price: ${itemProvider.getallitemsRecords!.data![index].unitprice}, Discount Rate: ${itemProvider.getallitemsRecords!.data![index].discountrate}, New Selling Price: ${itemProvider.getallitemsRecords!.data![index].discountprice}',
                                                        version:
                                                            QrVersions.auto,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            6,
                                                        gapless: false,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        commonMessage(context,
                                                            btnType: 3,
                                                            errorTxt:
                                                                "Are Your Sure Delete Seleected Item",
                                                            buttons: [
                                                              DialogButton(
                                                                child:
                                                                    Text("Yes"),
                                                                onPressed: () {
                                                                  itemProvider.deleteItemRecord(
                                                                      context,
                                                                      itemcode:
                                                                          "${itemProvider.getsearchDataModelData!.data![index].itemcode}");
                                                                },
                                                              ),
                                                              DialogButton(
                                                                child:
                                                                    Text("No"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ]).show();
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Text("No data"),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ));
  }
}
