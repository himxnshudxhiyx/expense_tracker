import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  final GlobalKey<FormState> addExpenseFormKey = GlobalKey<FormState>();

  TextEditingController expenseTitle = TextEditingController();
  TextEditingController expenseAmount = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();

  RxString dropdownValue = 'Food'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  addExpense() {
    final amount = double.tryParse(expenseAmount.text) ?? 0.0;
    homeController.expensesList.add(Expense(title: expenseTitle.text, amount: amount, category: dropdownValue.value));
    homeController.totalExpenses.value = homeController.totalExpenses.value + int.tryParse(expenseAmount.text)!;
    Get.back(result: true);
  }
}

class Expense {
  String title;
  double amount;
  String category;

  Expense({required this.title, required this.amount, required this.category});
}
