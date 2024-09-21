import 'package:expense_tracker/modules/profile/controller/profile_screen_controller.dart';
import 'package:get/get.dart';

class ProfileScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileScreenController>(ProfileScreenController());
  }

}