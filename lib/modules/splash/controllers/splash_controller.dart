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
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }
}
