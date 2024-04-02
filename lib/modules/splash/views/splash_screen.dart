import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  _bodyWidget() => SizedBox(
    width: Get.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Expense Tracker",
          style: TextStyle(fontSize: Get.height * 0.06),
        ).paddingOnly(bottom: Get.height * 0.05),
        Image.asset(
          splashIcon,
          // height: Get.height * 0.5,
          width: Get.width * 0.8,
        ),
      ],
    ),
  );
}
