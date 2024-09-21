import 'dart:convert';

import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:get/get.dart';

import '../../../constants/functions/flutter_error.dart';
import '../../../constants/functions/preference_manager.dart';

class ProfileScreenController extends GetxController {

  Rx<UserDetails> userDetails  = UserDetails().obs;

  @override
  void onInit() {
    getSavedUserData();
    super.onInit();
  }

  getSavedUserData() async {
    try {
      String data = await UserPreferences().getUserData() ?? "";
      var userData = jsonDecode(data);
      userDetails.value = UserDetails.fromJson(userData);
      userDetails.refresh();
      print("Ha bhaii ${userDetails.value.phoneNumber}");
    } catch (e, stack) {
      printFlutterError(error: e, stack: stack, runTimeType: runtimeType);
    }
  }

}