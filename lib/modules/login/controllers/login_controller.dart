import 'package:expense_tracker/constants/functions/api_manager.dart';
import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  callLoginApi() async {
    var startTime = DateTime.now().millisecondsSinceEpoch;
    try {
      var request = {
        'username' : emailController.text.toString(),
        'password' : passwordController.text.toString()
      };
      var getResponse = await ApiManager().post('auth/login', body: request);
      var endTime =  DateTime.now().millisecondsSinceEpoch;
      print("Time Taken to call api --> ${endTime - startTime} ms");
      // print('GET Response: ${getResponse.data}');
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
