import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/pages/add_item/add_item.dart';
import 'package:mobile_pos_adminpanell/provider/login_provider.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/main_body.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
                const Spacer(),
                kIsWeb ? Container() : Text('data')
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(child: Consumer(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CommonCard(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          ),
                          text: 'Add new item',
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const AddNewItem();
                              },
                            ));
                          },
                        ),
                        CommonCard(
                          icon: Icon(Icons.discount),
                          text: 'Add new offerce',
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
