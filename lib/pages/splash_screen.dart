import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:provider/provider.dart';
import 'package:mobile_pos_adminpanell/provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).loadAppData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<SplashProvider>(
          builder: (context, splashProvider, child) {
            if (splashProvider.getloadingPageData) {
              CommonLoader();
            }
            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/splashScreen.jpeg"),
                  //   fit: BoxFit.cover,
                  // ),
                  color: Color.fromARGB(255, 219, 219, 219),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
