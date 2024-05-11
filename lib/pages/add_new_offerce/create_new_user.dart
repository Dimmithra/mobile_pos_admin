import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/provider/user_reg_provider.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_searchable.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({super.key});

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserRegProvider>(context, listen: false)
          // ;
          .clearDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: 'Create new user',
      body: Consumer<UserRegProvider>(
        builder: (context, userRegProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      gradient: const SweepGradient(colors: [
                        Colors.white70,
                        Colors.white,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(
                              "assets/images/user_regestration.PNG",
                            ),
                            height: 120,
                          ),
                          Text('Create Your Own Account',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.indigo.shade900,
                                  fontWeight: FontWeight.bold)),
                          Text('Welcome',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.indigo.shade500,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? 550
                                  : MediaQuery.of(context).size.width,
                              child: CommonInput(
                                hintText: 'client Name',
                                label: 'client Name',
                                controller:
                                    userRegProvider.getclientNameController,
                                fullboader: true,
                                isValidate: true,
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
                                hintText: 'Mobile Number',
                                label: 'Mobile Number',
                                controller:
                                    userRegProvider.getmobileNoController,
                                fullboader: true,
                                isValidate: true,
                                maxLength: 10,
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
                                hintText: 'Address',
                                label: 'Address',
                                controller:
                                    userRegProvider.getaddressController,
                                fullboader: true,
                                isValidate: true,
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
                                hintText: 'Email',
                                label: 'Email',
                                controller: userRegProvider.getEmailController,
                                fullboader: true,
                                isValidate: true,
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
                                isPassword: true,
                                hintText: 'password',
                                label: 'password',
                                maxLines: 1,
                                controller:
                                    userRegProvider.getpasswordController,
                                fullboader: true,
                                isValidate: true,
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
                                isPassword: true,
                                hintText: 'Re-Enter Passwors',
                                label: 'Re-Enter Passwors',
                                maxLines: 1,
                                controller: userRegProvider
                                    .getreEnterPasswordController,
                                fullboader: true,
                                isValidate: true,
                              ),
                            ),
                          ),
                          userRegProvider.getloadSaveData
                              ? const CommonLoader()
                              : SizedBox(
                                  width: kIsWeb
                                      ? 550
                                      : MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonBtn(
                                      bntName: 'Submite',
                                      onPress: () {
                                        if (formKey.currentState!.validate()) {
                                          userRegProvider
                                              .textFeildValidation(context);
                                        }
                                      },
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
