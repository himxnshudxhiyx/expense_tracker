import 'package:expense_tracker/constants/functions/preference_manager.dart';
import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';
import '../../../main.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((token){
      fcmToken = token!;
      print("Token--->>>${token}");
    });
    navigateToNextScreen();
    super.onInit();
  }

  navigateToNextScreen() async {
    var authToken = await UserPreferences().getAuthToken() ?? '';
    if(authToken != '' && authToken.isNotEmpty) {
      checkUserApiCall();
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  checkUserApiCall() async {
    try {
      await ApiManager().get('auth/checkUser', auth: true).then((data) async {
        if (data['status'] == 200) {
          var jsonResponse = UserDetails.fromJson(data['user']);
          UserPreferences().saveUserData(jsonResponse);
          Get.offNamed(AppRoutes.home);
        } else {
          UserPreferences().clearAll();
          Get.offAllNamed(AppRoutes.login);
        }
      });
    } catch (e, stack) {
      UserPreferences().clearAll();
      Get.offAllNamed(AppRoutes.login);
      print('Error occurred: $e');
      print('Stack where occurred: $stack');
    }
  }
}
