import 'dart:async';

import 'package:expense_tracker/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateToNextScreen();
    super.onInit();
  }

  navigateToNextScreen() {
    Timer(Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }
}
