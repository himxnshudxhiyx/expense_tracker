import 'package:expense_tracker/modules/chatModule/views/chat_screen.dart';
import 'package:expense_tracker/modules/home/views/home_screen.dart';
import 'package:expense_tracker/modules/profile/bindings/profile_screen_bindings.dart';
import 'package:expense_tracker/modules/profile/controller/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../profile/view/profile_screen.dart';
import '../controller/main_screen_controller.dart';

class MainScreen extends GetView<MainScreenController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomeScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.deepPurple,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
            ],
            onTap: (val){
              if (val == 2) {
                if (!Get.isRegistered<ProfileScreenController>()) {
                  Get.put<ProfileScreenController>(ProfileScreenController());
                }
              }
            },
            enableFeedback: true,
            indicatorColor: Colors.white, // Color of the active tab indicator
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
          ),
        ),
      ),
    );
  }
}
