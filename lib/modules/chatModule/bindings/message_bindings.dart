import 'package:expense_tracker/modules/chatModule/controller/message_controller.dart';
import 'package:get/get.dart';

class MessageBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<MessageController>(MessageController());
  }

}