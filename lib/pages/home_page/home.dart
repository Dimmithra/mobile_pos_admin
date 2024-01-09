import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/login_provider.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: 'Welcome',
      drawer: Drawer(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            if (loginProvider.getloadingLoginData) {
              return const CommonLoader();
            }
            return Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/drawer.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountEmail:
                      Text("${loginProvider.loginModal!.user!.email}"),
                  accountName: Container(
                    child: Text(
                      "${loginProvider.loginModal!.user!.customername}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  currentAccountPicture: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/user_image.png'),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     child: CommonBtn(
                //       bntName: 'Sing Out',
                //       onPress: () {
                //         exit(0);
                //       },
                //       backgroundColor: Colors.red,
                //     ),
                //   ),
                // )
              ],
            );
          },
          // child: Column(
          //   children: [
          //     UserAccountsDrawerHeader(
          //       decoration: const BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage(
          //             'assets/images/drawer.png',
          //           ),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       accountEmail: const Text(''),
          //       accountName: Container(
          //         child: Text(
          //           "sjhd",
          //           style: const TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       currentAccountPicture: Container(
          //         decoration: const BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage('assets/images/user_image.png'),
          //           ),
          //         ),
          //       ),
          //     ),
          //     const Spacer(),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         width: MediaQuery.of(context).size.width,
          //         child: CommonBtn(
          //           bntName: 'Sing Out',
          //           onPress: () {
          //             exit(0);
          //           },
          //           backgroundColor: Colors.red,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
      body: SingleChildScrollView(),
    );
  }
}
