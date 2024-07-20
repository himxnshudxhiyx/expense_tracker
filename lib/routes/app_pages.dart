import 'package:expense_tracker/modules/add_expenses/bindings/add_expense_bindings.dart';
import 'package:expense_tracker/modules/add_expenses/views/add_expense_screen.dart';
import 'package:expense_tracker/modules/home/bindings/home_bindings.dart';
import 'package:expense_tracker/modules/home/views/home_screen.dart';
import 'package:expense_tracker/modules/login/views/login_screen.dart';
import 'package:expense_tracker/modules/splash/bindings/splash_binding.dart';
import 'package:expense_tracker/modules/splash/views/splash_screen.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/login/bindings/login_bindings.dart';
import '../modules/signUp/bindings/signUp_bindings.dart';
import '../modules/signUp/views/signUp_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: AppRoutes.addExpense,
      page: () => const AddExpenseScreen(),
      binding: AddExpenseBinding(),
    ),
  ];
}
