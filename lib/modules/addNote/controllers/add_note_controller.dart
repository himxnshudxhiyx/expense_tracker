import 'dart:convert';

import 'package:expense_tracker/constants/functions/toast_message.dart';
import 'package:expense_tracker/constants/models.dart';
import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';

class AddNoteController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxString noteId = ''.obs;
  final GlobalKey<FormState> addNoteKey = GlobalKey<FormState>();

  final HomeController controller = Get.find<HomeController>();


  saveNoteApiCall() async {
    try {
      var bodyData = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'noteStatus' : 'Active'
      };
      await ApiManager().post('notes/add', body: bodyData, auth: true).then((data) async {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        var jsonData= MessageResponseModel.fromJson(data);
        messageResponseModel = jsonData;
        showToast(messageResponseModel.message);
        if (messageResponseModel.statusCode == 201) {
          controller.onRefresh();
          titleController.clear();
          descriptionController.clear();
          Get.back();
          Get.back();
        }
      });
    } catch (e, stack) {
      print('Error occurred: $e');
      print('Stack where occurred: $stack');
    }
  }

  updateNoteApiCall() async {
    try {
      var bodyData = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'id':noteId.value,
        'noteStatus' : 'Updated'
      };
      await ApiManager().post('notes/update', body: bodyData, auth: true).then((data) async {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        var jsonData= MessageResponseModel.fromJson(data);
        messageResponseModel = jsonData;
        showToast(messageResponseModel.message);
        if (messageResponseModel.statusCode == 200) {
          controller.onRefresh();
          titleController.clear();
          descriptionController.clear();
          Get.back();
          Get.back();
        }
      });
    } catch (e, stack) {
      print('Error occurred: $e');
      print('Stack where occurred: $stack');
    }
  }
}
