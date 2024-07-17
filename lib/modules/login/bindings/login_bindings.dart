import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
