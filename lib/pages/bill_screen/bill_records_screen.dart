import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/bill_provider.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_searchable.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';

class BillRecordsScreens extends StatefulWidget {
  const BillRecordsScreens({super.key});

  @override
  State<BillRecordsScreens> createState() => _BillRecordsScreensState();
}

class _BillRecordsScreensState extends State<BillRecordsScreens> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BillProvider>(context, listen: false).clearData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "Bill Records Screen",
        body: Consumer<BillProvider>(
          builder: (context, billProvider, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonDropdownField(
                              jobRoleCtrl: billProvider.getsearchTypeController,
                              hintText: "Search Type",
                              items: ["Bill Number", "Email", "Mobile No"]),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: CommonInput(
                          fullboader: true,
                          hintText: "Search....",
                          label: "Search....",
                          controller: billProvider.getsearchItemController,
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
                                  billProvider.seachBillRecode(
                                    context,
                                    billNo: billProvider
                                                .getsearchTypeController.text ==
                                            "Bill Number"
                                        ? billProvider
                                            .getsearchItemController.text
                                        : "",
                                    cusEmail: billProvider
                                                .getsearchTypeController.text ==
                                            "Email"
                                        ? billProvider
                                            .getsearchItemController.text
                                        : "",
                                    cusModile: billProvider
                                                .getsearchTypeController.text ==
                                            "Mobile No"
                                        ? billProvider
                                            .getsearchItemController.text
                                        : "",
                                  );
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                billProvider.getbillRecordsModelData != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: ListView.builder(
                          itemCount: billProvider
                              .getbillRecordsModelData!.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 80),
                              child: billProvider.getloadBillPaymentRecords
                                  ? CommonLoader()
                                  : billProvider
                                              .getbillRecordsModelData!.data !=
                                          null
                                      ? Container(
                                          padding: EdgeInsets.only(top: 80),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade300),
                                          child: Column(children: [
                                            Row(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "SuperMarket",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.indigoAccent
                                                          .shade700),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.blue.shade900,
                                            ),
                                            Row(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${billProvider.getbillRecordsModelData!.data![index].cusName}"),
                                                Text(
                                                    "${billProvider.getbillRecordsModelData!.data![index].cusMobileno}"),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${billProvider.getbillRecordsModelData!.data![index].dateTime}"),
                                                Text(
                                                    "${billProvider.getbillRecordsModelData!.data![index].cusEmail}"),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Bill No: ${billProvider.getbillRecordsModelData!.data![index].billNo}"),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.blue.shade900,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5.5,
                                                      child: Text(
                                                        "Total:",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.indigo
                                                                .shade900),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${billProvider.getbillRecordsModelData!.data![index].totalAmount}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .indigo.shade900),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        child: Text(
                                                          "Discount",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .indigo
                                                                  .shade900),
                                                        )),
                                                    Text(
                                                      "${billProvider.getbillRecordsModelData!.data![index].tdiscountAmount}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .indigo.shade900),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        child: Text(
                                                          "Sub Total:",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .indigo
                                                                  .shade900),
                                                        )),
                                                    Text(
                                                      "${billProvider.getbillRecordsModelData!.data![index].subtotal}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .indigo.shade900),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        child: Text(
                                                          "No Of Items:",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .indigo
                                                                  .shade900),
                                                        )),
                                                    Text(
                                                        "${billProvider.getbillRecordsModelData!.data![index].itemcount}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.indigo
                                                                .shade900)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.blue.shade900,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade400,
                                                            border: Border(
                                                              top: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                                width: 1,
                                                              ),
                                                              bottom:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                  "Code",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.5,
                                                                child: Text(
                                                                  "Item Name",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    5,
                                                                child: Text(
                                                                  "Qty",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                  "Price  \n Rs.",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                  "Discount  \n Rs.",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                  "Total \n Rs.",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Colors
                                                          .indigo.shade900,
                                                      thickness: 1,
                                                    ),
                                                    if (billProvider
                                                        .getbillRecordsModelData!
                                                        .data!
                                                        .isNotEmpty)
                                                      //  billProvider.getitemData!.item!.isEmpty ? SizedBox.shrink() :
                                                      for (int i = 0;
                                                          billProvider
                                                                  .getbillRecordsModelData!
                                                                  .data![index]
                                                                  .item!
                                                                  .length >
                                                              // billProvider.getitemData!.item!.length >
                                                              i;
                                                          i++)
                                                        Container(
                                                          // padding: const EdgeInsets.only(
                                                          //     left: 5, right: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .indigo
                                                                    .shade900,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                child: Text("${billProvider.getbillRecordsModelData!.data![index].item![i].itemcode}"
                                                                    .replaceAll(
                                                                        "ProduCode-",
                                                                        "")),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.5,
                                                                child: Text(
                                                                    "${billProvider.billRecordsModelData!.data![index].item![i].name}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  child: Text(
                                                                      "${billProvider.billRecordsModelData!.data![index].item![i].qty}")),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    6,
                                                                child: Text(
                                                                    "${billProvider.billRecordsModelData!.data![index].item![i].amount}"),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                  "${billProvider.billRecordsModelData!.data![index].item![i].discountPrice}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade900,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Text(
                                                                    "${billProvider.billRecordsModelData!.data![index].item![i].itemTotal}"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: Text("No Data Founded"),
                                        ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink()
              ],
            );
          },
        ));
  }
}
