import 'package:expense_tracker/Widgets/elevated_button_widget.dart';
import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/modules/addNote/controllers/add_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/text_field.dart'; // Adjust the import path as needed

class AddNewNote extends StatefulWidget {
  final bool isEdit;
  final String? title;
  final String? description;
  final String? id;

  // Constructor to accept the parameter
  AddNewNote({required this.isEdit, this.title, this.description, this.id});
  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final AddNoteController controller = Get.put<AddNoteController>(AddNoteController());

  @override
  Widget build(BuildContext context) {
    print(controller.noteId.value);
    controller.noteId.value = widget.id??"0";
    controller.titleController.text = widget.title ?? "";
    controller.descriptionController.text = widget.description ?? "";
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: controller.addNoteKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextView(
                text: widget.isEdit ? "Update Note" : "Add New Note",
                fontSize: 20,
              ),
              SizedBox(height: 20),
              AppTextField(
                labelText: 'Title',
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              AppTextField(
                labelText: 'Description',
                controller: controller.descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButtonWidget(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                  if (controller.addNoteKey.currentState!.validate()) {
                    if (widget.isEdit == false) {
                      controller.saveNoteApiCall();
                    } else {
                      controller.updateNoteApiCall();
                    }
                  }
                },
                text: (widget.isEdit == true) ? 'Update' : 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}