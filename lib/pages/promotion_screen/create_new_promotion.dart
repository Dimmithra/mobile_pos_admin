import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/provider/promotion_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../utils/page_loader.dart';

class CreatePromotionScreen extends StatefulWidget {
  const CreatePromotionScreen({super.key});

  @override
  State<CreatePromotionScreen> createState() => _CreatePromotionScreenState();
}

class _CreatePromotionScreenState extends State<CreatePromotionScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PromotionProvider>(context, listen: false)
          .clearPromotionCreateData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: "Promotion",
      body: SingleChildScrollView(
        child: Consumer<PromotionProvider>(
          builder: (context, promotionProvider, child) {
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
                              image: AssetImage('assets/images/addproduct.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: kIsWeb
                                ? 550
                                : MediaQuery.of(context).size.width,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create New Promotion',
                                  style: TextStyle(
                                    color: kCommondarkBlue,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                              hintText: 'Promotion Headline',
                              label: 'Promotion Headline',
                              fullboader: true,
                              isValidate: true,
                              controller: promotionProvider
                                  .getpromotionHeadLineController,
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
                              hintText: 'Promotion Headline SubTitle',
                              label: 'Promotion Headline SubTitle',
                              fullboader: true,
                              isValidate: true,
                              controller: promotionProvider
                                  .getpromotionSubTitleController,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: kIsWeb
                        //         ? 550
                        //         : MediaQuery.of(context).size.width,
                        //     child: CommonInput(
                        //       hintText: 'Promotion Code',
                        //       label: 'Promotion Code',
                        //       fullboader: true,
                        //       isValidate: true,
                        //       controller: promotionProvider
                        //           .getpromotionCodeeControllerr,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: kIsWeb
                                ? 550
                                : MediaQuery.of(context).size.width,
                            child: CommonInput(
                              maxLines: 5,
                              hintText: 'Promotion Discription',
                              label: 'Promotion Discription',
                              fullboader: true,
                              isValidate: true,
                              controller: promotionProvider
                                  .getpromotionDiscriptionController,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: kIsWeb
                        //         ? 550
                        //         : MediaQuery.of(context).size.width,
                        //     child: CommonInput(
                        //       maxLines: 5,
                        //       hintText: 'Promotion ',
                        //       label: 'Promotion Discription',
                        //       fullboader: true,
                        //       isValidate: true,
                        //       controller: promotionProvider
                        //           .getpromotionDiscriptionController,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: kIsWeb
                                ? 550
                                : MediaQuery.of(context).size.width,
                            child: InkWell(
                              onTap: () async {
                                final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 365 * 50)),
                                );
                                if (dateTime != null) {
                                  promotionProvider.selecteddate = dateTime;
                                  promotionProvider
                                          .getpromotionDateController.text =
                                      "${promotionProvider.selecteddate.toLocal()}"
                                          .split(' ')[0];
                                }
                              },
                              child: IgnorePointer(
                                ignoring: true,
                                child: CommonInput(
                                  label: 'Promotion date',
                                  hintText: 'Promotion date',
                                  fullboader: true,

                                  // backgroundcolor: kDropBackground,
                                  filled: true,
                                  // bordercolor: kWhiteBorder,
                                  controller: promotionProvider
                                      .getpromotionDateController,
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
                              child: promotionProvider.loadingCreateData
                                  ? const CommonLoader()
                                  : CommonBtn(
                                      bntName: 'Submite',
                                      onPress: () {
                                        if (formKey.currentState!.validate()) {
                                          promotionProvider.CreateNewPromotion(
                                              context);
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
      ),
    );
  }
}
