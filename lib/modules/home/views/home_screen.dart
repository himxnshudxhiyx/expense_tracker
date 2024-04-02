import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result = await Get.toNamed(AppRoutes.addExpense);
            if (result == true) {
              controller.getExpenseByCategory();
            }
          },
          elevation: 0,
          tooltip: 'Add Expenses',
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  _bodyWidget() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${controller.getGreeting()},",
              style: TextStyle(fontSize: Get.height * 0.04),
            ).paddingOnly(
              bottom: Get.height * 0.04,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(
                  Get.width * 0.05,
                ),
              ),
              padding: EdgeInsets.all(
                Get.width * 0.05,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Expenses",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Get.width * 0.06,
                          color: Colors.grey,
                        ),
                      ).paddingAll(
                        Get.width * 0.03,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Get.width * 0.05,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Obx(
                    () => Text(
                      "₹ ${controller.totalExpenses}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Get.width * 0.06),
                    ).paddingAll(
                      Get.width * 0.03,
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(
              horizontal: Get.height * 0.05,
            ),
            Obx(
              () => (controller.expensesList.isNotEmpty == true) ? _expensesChart() : Container(),
            ),
            _expensesList(),
          ],
        ).paddingAll(
          Get.height * 0.01,
        ),
      );

  _expensesChart() {
    RxMap<String, double> dataMap = controller.getExpenseByCategory().obs;
    return SizedBox(
      height: Get.height * 0.4,
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<MapEntry<String, double>, String>(
            dataSource: dataMap.entries.toList(),
            xValueMapper: (entry, _) => entry.key,
            yValueMapper: (entry, _) => entry.value,
            dataLabelMapper: (entry, _) => '${entry.key}: ${entry.value.toStringAsFixed(0)} ₹',
            // Display category name and total expense
            dataLabelSettings: const DataLabelSettings(isVisible: true), // Show data labels
          ),
        ],
      ),
    );
  }

  _expensesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overall Expenses -",
          style: TextStyle(
            fontSize: Get.height * 0.03,
          ),
        ).paddingOnly(
          left: Get.height * 0.02,
        ),
        Obx(
          () => (controller.expensesList.isNotEmpty)
              ? ListView.builder(
                  primary: false,
                  itemCount: controller.expensesList.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _expenseDetails(
                      title: controller.expensesList[index].title,
                      amount: controller.expensesList[index].amount.toStringAsFixed(0),
                      category: controller.expensesList[index].category,
                    );
                  },
                )
              : SizedBox(
                  height: Get.height * 0.5,
                  child: Center(
                    child: Text(
                      "No Expenses Found",
                      style: TextStyle(fontSize: Get.height * 0.02),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  _expenseDetails({title, amount, category}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade100,
        borderRadius: BorderRadius.circular(
          Get.width * 0.03,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "N/A",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.width * 0.06,
                  color: Colors.black,
                ),
              ).paddingAll(
                Get.width * 0.03,
              ),
              Text(
                "$amount ₹",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.width * 0.06,
                  color: Colors.red,
                ),
              ).paddingAll(
                Get.width * 0.03,
              ),
            ],
          ),
          Text(
            category ?? "N/A",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.width * 0.06,
              color: Colors.grey,
            ),
          ).paddingAll(
            Get.width * 0.03,
          ),
        ],
      ),
    ).paddingAll(
      Get.width * 0.03,
    );
  }
}
