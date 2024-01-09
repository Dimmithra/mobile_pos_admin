import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/provider/login_provider.dart';
import 'package:mobile_pos_adminpanell/utils/internetconnection_class.dart';
import 'package:mobile_pos_adminpanell/utils/message.dart';
import 'package:mobile_pos_adminpanell/utils/page_loader.dart';
import 'package:mobile_pos_adminpanell/widgets/common_btn.dart';
import 'package:mobile_pos_adminpanell/widgets/common_textfeild.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    InternetConnectionChecker().isInternetAvailable(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).clearData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.grey),
                ),
                child: Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/loginImage.png'),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 22, 41),
                              ),
                            ),
                            const Text(
                              'Ponit of sales managment system',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 22, 41),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 500,
                                child: CommonInput(
                                  hintText: 'Enter Your Email',
                                  label: 'Enter Your Email',
                                  isValidate: true,
                                  suffix: const Icon(Icons.email),
                                  controller: loginProvider.getemailController,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 500,
                                child: CommonInput(
                                  hintText: 'Enter Your Password',
                                  label: 'Enter Your Password',
                                  isValidate: true,
                                  isPassword: true,
                                  suffix: Icon(Icons.password_sharp),
                                  controller:
                                      loginProvider.getpasswordController,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 500,
                                child: loginProvider.loadingLoginData
                                    ? CommonLoader()
                                    : CommonBtn(
                                        bntName: 'Sign Up',
                                        onPress: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            loginProvider
                                                .loginResponce(context);
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
