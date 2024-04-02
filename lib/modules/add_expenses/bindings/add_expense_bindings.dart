import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:get/get.dart';

class AddExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddExpenseController>(AddExpenseController());
  }
}
