import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';

class SearchItemRecords extends StatefulWidget {
  const SearchItemRecords(
      {super.key,
      required this.itemCode,
      required this.companyName,
      required this.productName,
      required this.price,
      required this.qty,
      required this.mDate,
      required this.eDate,
      required this.imageUrl,
      required this.discountRate,
      required this.disStartDate,
      required this.disEndDate});
  final String itemCode;
  final String companyName;
  final String productName;
  final String price;
  final String qty;
  final String mDate;
  final String eDate;
  final String imageUrl;
  final String discountRate;
  final String disStartDate;
  final String disEndDate;
  @override
  State<SearchItemRecords> createState() => _SearchItemRecordsState();
}

class _SearchItemRecordsState extends State<SearchItemRecords> {
  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "Search",
        body: SingleChildScrollView(
          child: Column(
            children: [
              CommonInput(
                hintText: "${widget.companyName}",
                label: "${widget.companyName}",
              ),
              CommonInput(
                hintText: "${widget.productName}",
                label: "${widget.productName}",
              ),
              CommonInput(
                hintText: "${widget.price}",
                label: "${widget.price}",
              ),
              CommonInput(
                hintText: "${widget.price}",
                label: "${widget.price}",
              ),
            ],
          ),
        ));
  }
}
