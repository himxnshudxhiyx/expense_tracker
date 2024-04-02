import 'package:expense_tracker/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
