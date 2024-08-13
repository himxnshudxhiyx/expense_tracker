import 'dart:convert';
import 'dart:developer';

import 'package:expense_tracker/constants/functions/api_manager.dart';
import 'package:expense_tracker/constants/functions/flutter_error.dart';
import 'package:expense_tracker/constants/functions/preference_manager.dart';
import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../constants/functions/toast_message.dart';
import '../../../main.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool passwordVisible = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  LoginApiResponseModel loginApiResponseModel = LoginApiResponseModel();

  @override
  void onInit() {
    if (kDebugMode){
      emailController.text = 'himanshu.44909@gmail.com';
      passwordController.text = 'Himanshu@44909';
    }
    // TODO: implement onInit
    super.onInit();
  }

  callLoginApi() async {
    log("TOKEN--->>>${fcmToken}");
    try {
      var request = {
        'username': emailController.text.toString(),
        'password': passwordController.text.toString(),
        'fcmToken': fcmToken,
      };
      await ApiManager().post('auth/login', body: request).then((data) async {
        var jsonResponse = LoginApiResponseModel.fromJson(data);
        loginApiResponseModel = jsonResponse;
        showToast(loginApiResponseModel.message);
        if(loginApiResponseModel.statusCode == 200) {
          UserPreferences().saveUserData(loginApiResponseModel.user!);
          UserPreferences().saveAuthToken(loginApiResponseModel.authToken!);
          Get.offNamed(AppRoutes.home);
        }
        // var userData = await UserPreferences().getUserData();
        // print("UserData${ jsonDecode(userData.toString()) }");
      });
      // print('GET Response: ${getResponse.data}');
    } catch (e, stack) {
      printFlutterError(runTimeType: runtimeType, stack: stack, error: e.toString());
    }
  }
}
