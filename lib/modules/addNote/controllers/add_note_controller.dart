import 'dart:developer';

import 'package:expense_tracker/constants/functions/toast_message.dart';
import 'package:expense_tracker/constants/models.dart';
import 'package:expense_tracker/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../constants/functions/api_manager.dart';

class AddNoteController extends GetxController {
  final bool isEdit;
  final String? title;
  final String? description;
  final String? id;

  AddNoteController(
      {required this.isEdit, this.id, this.title, this.description});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxBool speechEnabled = false.obs;
  SpeechToText speechToText = SpeechToText();
  RxString lastWords = ''.obs;

  @override
  void onInit() {
    if (isEdit) {
      noteId.value = id ?? "0";
      titleController.text = title ?? "";
      descriptionController.text = description ?? "";
    }
    initSpeech();
    super.onInit();
  }

  initSpeech() async {
    speechEnabled.value = await speechToText.initialize(
        debugLogging: true,
        finalTimeout: Duration(seconds: 60),
        onError: (e) {
          log("ERROR--->>>${e.toString()}");
        });
  }

  startListening() async {
    try {
      log("LISTEN STARTED");
      await speechToText.listen(
        listenOptions: SpeechListenOptions(autoPunctuation: true),
        onResult: (result) {
          log("FINISHED");
          onSpeechResult(result);
        },
      );
    } catch (e, stack) {
      log("ERROR--->>>${e.toString()}");
      log("STACK--->>>${stack}");
    }
  }

  stopListening() async {
    await speechToText.stop();
    log("STOPPED");
  }

  onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    titleController.text = lastWords.value;
    log("SPEECH RESULT --->>> ${lastWords.value}");
    stopListening();
  }

  RxString noteId = ''.obs;
  final GlobalKey<FormState> addNoteKey = GlobalKey<FormState>();

  final HomeController controller = Get.find<HomeController>();

  saveNoteApiCall() async {
    try {
      var bodyData = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'noteStatus': 'Active'
      };
      await ApiManager()
          .post('notes/add', body: bodyData, auth: true)
          .then((data) async {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        var jsonData = MessageResponseModel.fromJson(data);
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
        'id': noteId.value,
        'noteStatus': 'Updated'
      };
      await ApiManager()
          .post('notes/update', body: bodyData, auth: true)
          .then((data) async {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        var jsonData = MessageResponseModel.fromJson(data);
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
