import 'package:expense_tracker/modules/addNote/controllers/add_note_controller.dart';
import 'package:get/get.dart';

class AddNoteBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AddNoteController>(AddNoteController());
  }

}