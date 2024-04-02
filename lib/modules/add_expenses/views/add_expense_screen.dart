import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/modules/add_expenses/controllers/add_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends GetView<AddExpenseController> {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Add your expenses",
            style: TextStyle(fontSize: Get.height * 0.04),
          ).paddingOnly(
            bottom: Get.height * 0.03,
            top: Get.height * 0.03,
          ),
          Form(
            key: controller.addExpenseFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(fontSize: Get.width * 0.04),
                  controller: controller.expenseTitle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    errorBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    focusedErrorBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    filled: true,
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: Get.width * 0.05,
                      color: Colors.red.shade200,
                    ),
                  ),
                ).paddingOnly(
                  bottom: Get.width * 0.05,
                ),
                TextFormField(
                  style: TextStyle(fontSize: Get.width * 0.04),
                  controller: controller.expenseAmount,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    errorBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    focusedErrorBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.red.shade200)),
                    filled: true,
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                      fontSize: Get.width * 0.05,
                      color: Colors.red.shade200,
                    ),
                  ),
                ).paddingOnly(
                  bottom: Get.width * 0.05,
                ),
                Obx(
                  () => Container(
                    padding: EdgeInsets.only(left: Get.width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: DropdownButton<String>(
                      hint: Text("Select Category"),
                      underline: Container(),
                      isExpanded: true,
                      alignment: Alignment.bottomCenter,
                      value: controller.dropdownValue.value,
                      onChanged: (String? newValue) {
                        controller.dropdownValue.value = newValue!;
                      },
                      items: <String>['Food', 'Shopping', 'House Rent', 'EMIs', 'Other'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ).paddingOnly(
                  bottom: Get.width * 0.05,
                ),
              ],
            ).paddingAll(
              Get.width * 0.05,
            ),
          ),
          Center(
            child: MaterialButton(
              padding: EdgeInsets.all(Get.width * 0.025),
              elevation: 0.0,
              minWidth: Get.width * 0.3,
              color: Colors.red.shade200,
              onPressed: () {
                if (controller.addExpenseFormKey.currentState!.validate()) {
                  if (controller.dropdownValue.value.toString().isNotEmpty == true) {
                    controller.addExpense();
                  } else {
                    toast("Please select category");
                  }
                }
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: Get.width * 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
