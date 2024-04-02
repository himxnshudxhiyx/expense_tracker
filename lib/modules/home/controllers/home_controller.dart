import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt totalExpenses = 0.obs;

  RxList<Expense> expensesList = <Expense>[].obs;

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
}
