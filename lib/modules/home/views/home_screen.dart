import 'package:expense_tracker/Widgets/elevated_button_widget.dart';
import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/common_functions.dart';
import '../../addNote/controllers/add_note_controller.dart';
import '../../addNote/views/add_note_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                fontColor: Colors.white,
                text: "${controller.getGreeting()},",
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {},
                  child: TextView(
                    fontColor: Colors.white,
                    text:
                        "${controller.userDetails.value.firstName ?? ""} ${controller.userDetails.value.lastName ?? ""}",
                    // style: TextStyle(fontSize: Get.height * 0.025),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.hitLogoutApi();
              },
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ).paddingOnly(right: 10),
          ],
        ),
        floatingActionButton: _floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, // Use a fixed location
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling, // Or use a custom animator if needed
        body: _bodyWidget(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     var result = await Get.toNamed(AppRoutes.addExpense);
        //     if (result == true) {
        //       controller.getExpenseByCategory();
        //     }
        //   },
        //   elevation: 0,
        //   tooltip: 'Add Expenses',
        //   backgroundColor: Colors.redAccent,
        //   child: Icon(
        //     Icons.add,
        //   ),
        // ),
    );
  }

  _floatingActionButton() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (controller.addButtonClicked.value)
                ? Align(
              alignment: Alignment.centerRight,
                  child: Container(
                      width:200.w,
                      color: Colors.white, // Background color of the button
                      child: _addNotes(),
                    ),
                )
                : SizedBox.shrink(),
            FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                controller.addButtonClicked.value =
                    !controller.addButtonClicked.value;
              },
              child: (!controller.addButtonClicked.value)
                  ? Icon(
                      Icons.add_rounded,
                    )
                  : Icon(
                      Icons.close,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // _bodyWidget() => RefreshIndicator(
  //       displacement: 50,
  //       triggerMode: RefreshIndicatorTriggerMode.anywhere,
  //       onRefresh: () async {
  //         return await controller.onRefresh();;
  //       },
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             _addNotes(),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.red.shade50,
  //                 borderRadius: BorderRadius.circular(
  //                   Get.width * 0.05,
  //                 ),
  //               ),
  //               padding: EdgeInsets.all(
  //                 Get.width * 0.05,
  //               ),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Total Expenses",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontSize: Get.width * 0.06,
  //                           color: Colors.grey,
  //                         ),
  //                       ).paddingAll(
  //                         Get.width * 0.03,
  //                       ),
  //                       Icon(
  //                         Icons.arrow_forward_ios_rounded,
  //                         size: Get.width * 0.05,
  //                         color: Colors.grey,
  //                       )
  //                     ],
  //                   ),
  //                   Obx(
  //                     () => Text(
  //                       "₹ ${controller.totalExpenses}",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(fontSize: Get.width * 0.06),
  //                     ).paddingAll(
  //                       Get.width * 0.03,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ).paddingSymmetric(
  //               horizontal: Get.height * 0.05,
  //             ),
  //             // Obx(
  //             //   () => (controller.expensesList.isNotEmpty == true)
  //             //       ? _expensesChart()
  //             //       : Container(),
  //             // ),
  //             _notesList(),
  //           ],
  //         ).paddingAll(
  //           Get.height * 0.01,
  //         ),
  //       ),
  //     );

  _bodyWidget() => RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await controller.onRefresh();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _notesList(),
              // Extra space to push content up and ensure scrolling if content is small
              // SizedBox(
              //     height: Get.height * 0.1), // Adjust height as needed
              // ],
              // ),
            ),
          ],
        ),
      );

  // _expensesChart() {
  //   RxMap<String, double> dataMap = controller.getExpenseByCategory().obs;
  //   return SizedBox(
  //     height: Get.height * 0.4,
  //     child: SfCircularChart(
  //       series: <CircularSeries>[
  //         PieSeries<MapEntry<String, double>, String>(
  //           dataSource: dataMap.entries.toList(),
  //           xValueMapper: (entry, _) => entry.key,
  //           yValueMapper: (entry, _) => entry.value,
  //           dataLabelMapper: (entry, _) =>
  //               '${entry.key}: ${entry.value.toStringAsFixed(0)} ₹',
  //           // Display category name and total expense
  //           dataLabelSettings:
  //               const DataLabelSettings(isVisible: true), // Show data labels
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _addNotes() {
    return ElevatedButtonWidget(
      text: "Add Notes",
      onPressed: () {
        controller.addButtonClicked.value = !controller.addButtonClicked.value;
        showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          builder: (context) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: AddNewNote(isEdit: false),
            );
          },
        ).then((_) {
          Get.delete<AddNoteController>();
          // controller.onRefresh();
        });
      },
    ).paddingOnly(bottom: 5.sp);
  }

  _notesList() {
    return Container(
      height:
          MediaQuery.of(Get.context!).size.height * 0.8, // or any fixed height
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            textAlign: TextAlign.start,
            text: "My Notes",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ).paddingAll(10).paddingOnly(left: 7),
          Expanded(
            child: Obx(
              () => (controller.notesList.isEmpty &&
                      controller.notesListLoading.value == false)
                  ? Center(
                      child: TextView(
                        text: "No Notes Found",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : (controller.notesListLoading.value != true)
                      ? ListView.builder(
                          primary: false,
                          itemCount: controller.notesList.length,
                          itemBuilder: (context, index) {
                            return notesListTile(
                              title: controller.notesList[index].title,
                              description:
                                  controller.notesList[index].description,
                              id: controller.notesList[index].id,
                              createdOn: controller.notesList[index].createdAt,
                              status: controller.notesList[index].noteStatus,
                            );
                          },
                        )
                      : shimmerNotesListTile(),
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerNotesListTile() {
    return ListView.builder(
      itemCount: 7,
      shrinkWrap: true,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect for title
              Container(
                width: 100,
                height: 16,
                color: Colors.grey[300],
              ),
              SizedBox(height: 8),
              // Shimmer effect for description
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.grey[300],
              ),
              SizedBox(height: 8),
              Container(
                width: 150,
                height: 14,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }

  notesListTile({title, description, id, createdOn, status}) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          (status == 'Done')
              ? SizedBox()
              : SlidableAction(
                  onPressed: (_) {
                    showModalBottomSheet(
                      context: Get.context!,
                      isScrollControlled: true,
                      builder: (context) {
                        print("id:${id}");
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: AddNewNote(
                              isEdit: true,
                              title: title,
                              description: description,
                              id: id),
                        );
                      },
                    ).then((_) {
                      Get.delete<AddNoteController>();
                      // controller.onRefresh();
                    });
                  },
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,

                  // label: 'Edit',
                  flex: 1, // Adjust flex as needed
                ),
          SlidableAction(
            onPressed: (_) {
              controller.deleteNoteApiCall(id: id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            // label: 'Delete',
            flex: 1, // Adjust flex as needed
          ),
          (status == 'Done')
              ? SizedBox()
              : SlidableAction(
                  onPressed: (_) {
                    controller.updateNoteStatus(noteId: id);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.done_rounded,
                  // label: 'Mark As\n Done',
                  flex: 1, // Adjust flex as needed
                ),
        ],
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 7),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontColor: Colors.black,
              style: TextStyle(
                decoration: (status != 'Active' || status != "Updated")
                    ? TextDecoration.lineThrough
                    : null, // Adds the strikethrough line
              ),
            ),
            SizedBox(height: 8), // Add spacing between title and description
            TextView(
              text: convertDateFormat(dateString: createdOn),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontColor: Colors.black,
              style: TextStyle(
                decoration: (status != 'Active' || status != "Updated")
                    ? TextDecoration.lineThrough
                    : null, // Adds the strikethrough line
              ),
            ),
            SizedBox(height: 8), // Add spacing between title and description
            TextView(
              text: description,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontColor: Colors.black,
              style: TextStyle(
                decoration: (status != 'Active' || status != "Updated")
                    ? TextDecoration.lineThrough
                    : null, // Adds the strikethrough line
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    ).marginAll(5);
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
