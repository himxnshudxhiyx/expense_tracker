import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/signUp_controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}
