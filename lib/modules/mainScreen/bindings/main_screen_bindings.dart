import 'package:get/get.dart';

import '../controller/main_screen_controller.dart';

class MainScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MainScreenController>(MainScreenController());
    // TODO: implement dependencies
  }

}