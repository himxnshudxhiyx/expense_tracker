import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/modules/profile/controller/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: 'Profile Screen', fontColor: Colors.white,),
      ),
      body: Obx(() => ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: TextView(text: "${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName}"),
            subtitle: Text('Full Name'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(controller.userDetails.value.username.toString()),
            subtitle: Text('Email'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(controller.userDetails.value.phoneNumber.toString()),
            subtitle: Text('Phone Number'),
          ),
        ],
      ),),
    );
  }
}