import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/text_field.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/elevated_button_widget.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: _bodyWidget(),
      ),
    );
  }

  // _bodyWidget() => SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           TextView(text: "Login to continue", fontSize: 26,),
  //         ],
  //       ).paddingAll(
  //         Get.height * 0.01,
  //       ),
  //     );
    _bodyWidget() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            Colors.pinkAccent,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(loginIcon, height: 200, width: 200,),
          Card(
            elevation: 4,
            margin: EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.7),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    labelText: 'Email',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    labelText: 'Password',
                    controller: controller.passwordController,
                    obscureText: true,
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility), // Example of suffix icon
                  ),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    text: 'Login',
                    textColor: Colors.white,
                    onPressed: () {
                      controller.callLoginApi();
                      // Handle login logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
}
