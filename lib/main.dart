import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/pages/splash_screen.dart';
import 'package:mobile_pos_adminpanell/provider/bill_provider.dart';
import 'package:mobile_pos_adminpanell/provider/item_provider.dart';
import 'package:mobile_pos_adminpanell/provider/login_provider.dart';
import 'package:mobile_pos_adminpanell/provider/promotion_provider.dart';
import 'package:mobile_pos_adminpanell/provider/splash_provider.dart';
import 'package:mobile_pos_adminpanell/provider/user_reg_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ItemProvider()),
      ChangeNotifierProvider(create: (_) => PromotionProvider()),
      ChangeNotifierProvider(create: (_) => UserRegProvider()),
      ChangeNotifierProvider(create: (_) => BillProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mobile pos admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
