import 'dart:convert';
import 'dart:math';

import 'package:expense_tracker/constants/models.dart';
import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:expense_tracker/modules/login/models/login_api_response_model.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';
import '../../../constants/functions/flutter_error.dart';
import '../../../constants/functions/preference_manager.dart';
import '../../../constants/functions/toast_message.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  RxInt totalExpenses = 0.obs;

  RxList<Expense> expensesList = <Expense>[].obs;

  void onInit(){
    getSavedData();
    getNotesListApiCall();
    super.onInit();
  }

  Map<String, double> getExpenseByCategory() {
    Map<String, double> categoryAmountMap = {};
    for (var expense in expensesList) {
      if (categoryAmountMap.containsKey(expense.category)) {
        categoryAmountMap[expense.category] = categoryAmountMap[expense.category]! + expense.amount;
      } else {
        categoryAmountMap[expense.category] = expense.amount;
      }
    }
    return categoryAmountMap;
  }

  String getGreeting() {
    var now = DateTime.now();
    if (now.hour < 12) {
      return 'Good Morning';
    } else if (now.hour < 16) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Rx<UserDetails> userDetails = UserDetails().obs;

  getSavedData() async {
    try{
      String data = await UserPreferences().getUserData() ?? "";
      var userData = jsonDecode(data);
      userDetails.value = UserDetails.fromJson(userData);
      userDetails.refresh();
    } catch (e, stack){
      printFlutterError(error: e,stack: stack, runTimeType: runtimeType);
    }
  }

  getNotesListApiCall() async {
    try {
      await ApiManager().get('notes/', auth: true).then((data) async {
        print(data);
        // var jsonResponse = UserDetails.fromJson(data);
        // UserPreferences().saveUserData(jsonResponse);
        // Get.offNamed(AppRoutes.home);
      });
    } catch (e, stack) {
      print('Error occurred: $e');
      print('Stack where occurred: $stack');
    }
  }

  hitLogoutApi() async {
    try {
      await ApiManager().post('auth/logout', auth: true).then((data) async {
        var jsonResponse = MessageResponseModel.fromJson(data);
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = jsonResponse;
        showToast(messageResponseModel.message);
        if(messageResponseModel.statusCode == 200) {
          UserPreferences().clearAll();
          Get.offAllNamed(AppRoutes.login);
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
