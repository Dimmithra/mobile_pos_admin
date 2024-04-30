import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/pages/edit_product_details/search_items.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rflutter_alert/rflutter_alert.dart';

class EditProductDetails extends StatefulWidget {
  const EditProductDetails({super.key});

  @override
  State<EditProductDetails> createState() => _EditProductDetailsState();
}

class _EditProductDetailsState extends State<EditProductDetails> {
  void initState() {
    // InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemProvider>(context, listen: false)
          .getAllItemsRecords(context);
    });
    // FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: 'Edit Product Details',
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          if (itemProvider.getloadingAddItemData ||
              itemProvider.getloadGetAllItems) {
            return const CommonLoader();
          }
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchItems(),
                                    ));
                              },
                              child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Icon(
                                      Icons.search,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                              children: [
                                Row(
                                  children: [
                                    // kIsWeb
                                    //     ? itemProvider
                                    //             .getallitemsRecords!
                                    //             .data![index]
                                    //             .image_url!
                                    //             .isNotEmpty
                                    //         ? Image(
                                    //             height: 100,
                                    //             width: 100,
                                    //             image: NetworkImage(
                                    //                 "${itemProvider.getallitemsRecords!.data![index].image_url}"))
                                    //         : Text("")
                                    //     :
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${itemProvider.getallitemsRecords!.data![index].image_url}',
                                        height: 80,
                                        width: 80,
                                        placeholder: (context, url) {
                                          return const CircularProgressIndicator();
                                        },
                                        errorWidget: (context, url, error) {
                                          return SizedBox.shrink();
                                        },
                                        // fadeInDuration:
                                        //     const Duration(seconds: 3),
                                      ),
                                      //     FastCachedImage(
                                      //   url: itemProvider.getallitemsRecords!
                                      //           .data![index].image_url!.isEmpty
                                      //       ? ""
                                      //       : itemProvider.getallitemsRecords!
                                      //           .data![index].image_url
                                      //           .toString(),
                                      //   // fit: BoxFit.cover,
                                      //   loadingBuilder: (context, progress) {
                                      //     return Container(
                                      //       // color: Colors.yellow,
                                      //       child: Stack(
                                      //         alignment: Alignment.center,
                                      //         children: [
                                      //           // if (progress.isDownloading &&
                                      //           //     progress.totalBytes != null)
                                      //           //   Text(
                                      //           //       '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                                      //           //       style: const TextStyle(
                                      //           //           color: Colors.red)),
                                      //           SizedBox(
                                      //               width: 120,
                                      //               height: 120,
                                      //               child:
                                      //                   CircularProgressIndicator(
                                      //                 color: Colors.red,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     );
                                      //   },
                                      //   fadeInDuration:
                                      //       const Duration(seconds: 1),
                                      //   errorBuilder:
                                      //       (context, exception, stacktrace) {
                                      //     return Text(stacktrace.toString());
                                      //   },
                                      // ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${itemProvider.getallitemsRecords!.data![index].itemname}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 29, 80)),
                                        ),
                                        Text(
                                          '${itemProvider.getallitemsRecords!.data![index].discountAvailable == false ? 'No Discount Available' : 'Discount Available'}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        itemProvider
                                                    .getallitemsRecords!
                                                    .data![index]
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 34, 38, 255)),
                                                  ),
                                                  Text(
                                                    '${itemProvider.getallitemsRecords!.data![index].dicountIssuDate} To ${itemProvider.getallitemsRecords!.data![index].dicountExpiredDate}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 85, 87, 255)),
                                                  ),
                                                ],
                                              )
                                            : SizedBox.shrink(),
                                        Text(
                                            "Discription: ${itemProvider.getallitemsRecords!.data![index].itemdescription}"),
                                        Text(
                                            "Price: ${itemProvider.getallitemsRecords!.data![index].unitprice}"),
                                        Text(
                                            "Manufecture Date: ${itemProvider.getallitemsRecords!.data![index].manifectdate}"),
                                        Text(
                                            "Expire Date: ${itemProvider.getallitemsRecords!.data![index].expdate!.isNotEmpty ? itemProvider.getallitemsRecords!.data![index].expdate : ''}")
                                      ],
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
                                                  itemProvider.deleteItemRecord(
                                                      context,
                                                      itemcode:
                                                          "${itemProvider.getallitemsRecords!.data![index].itemcode}");
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
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
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
