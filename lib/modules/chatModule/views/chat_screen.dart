import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//         leading: InkWell(
//           onTap: (){
// Get.toNamed(AppRoutes.main);          },
//           child: Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.white,
//           ),
//         ),
        title: TextView(
          text: "Chat",
          fontColor: Colors.white,
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
        child: Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
      body: _allChatWidget(),
    );
  }

  _allChatWidget() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.allUsersList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.messageScreen, arguments: {
                'personName':
                    '${controller.allUsersList[index].firstName} ${controller.allUsersList[index].lastName}',
                'emailId': '${controller.allUsersList[index].username}',
                'phoneNumber': '${controller.allUsersList[index].phoneNumber}'
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Colors.grey.shade200),
              padding: EdgeInsets.all(10.sp),
              margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text:
                        '${controller.allUsersList[index].firstName} ${controller.allUsersList[index].lastName}',
                  ),
                  TextView(
                    text: '${controller.allUsersList[index].phoneNumber}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
