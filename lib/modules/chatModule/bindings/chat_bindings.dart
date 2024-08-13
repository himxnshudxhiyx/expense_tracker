import 'package:expense_tracker/modules/chatModule/controller/chat_controller.dart';
import 'package:get/get.dart';

class ChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController());
  }

}