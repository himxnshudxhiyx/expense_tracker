import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expense_tracker/constants/functions/api_manager.dart';
import 'package:expense_tracker/constants/functions/preference_manager.dart';
import 'package:expense_tracker/constants/functions/toast_message.dart';
import 'package:expense_tracker/constants/models.dart';
import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../constants/functions/flutter_error.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool passwordVisible = true.obs;

  @override
  void onInit() {
    if(kDebugMode) {
      emailController.text = 'himanshu.44909@gmail.com';
      firstNameController.text = 'Himanshu';
      lastNameController.text = 'Dahiya';
      phoneNumberController.text = '+918930144909';
      passwordController.text = 'Himanshu@44909';
    }
    // TODO: implement onInit
    super.onInit();
  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  LoginApiResponseModel loginApiResponseModel = LoginApiResponseModel();

  callSignUpApi() async {
    try {
      var request = {
        "username": emailController.text.toString(),
        "password": passwordController.text.toString(),
        "firstName": firstNameController.text.toString(),
        "lastName": lastNameController.text.toString(),
        "phoneNumber": phoneNumberController.text.toString()
      };
      await ApiManager().post('auth/signup', body: request).then((data) async {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        var jsonResponse = MessageResponseModel.fromJson(data);
        messageResponseModel = jsonResponse;
        showToast(messageResponseModel.message);
        if (messageResponseModel.statusCode == 201) {
          Get.back();
        }
      });
      // print('GET Response: ${getResponse.data}');
    } catch (e, stack) {
      printFlutterError(
          error: e.toString(), stack: stack, runTimeType: runtimeType);
    }
  }
}
