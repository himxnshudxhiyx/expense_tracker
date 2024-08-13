import 'package:expense_tracker/Widgets/elevated_button_widget.dart';
import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/modules/addNote/controllers/add_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/text_field.dart'; // Adjust the import path as needed

class AddNewNote extends StatelessWidget {
  final bool isEdit;
  final AddNoteController controller;
  final String? title;
  final String? description;
  final String? id;

  // Constructor to accept the parameter
  AddNewNote({required this.isEdit, this.title, this.description, this.id})
      : controller = Get.put(AddNoteController(
            isEdit: isEdit, id: id, description: description, title: title));

  // final AddNoteController controller = Get.put<AddNoteController>(AddNoteController(isEdit: isEdit));

  @override
  Widget build(BuildContext context) {
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
                text: isEdit ? "Update Note" : "Add New Note",
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
                // suffixWidget: InkWell(
                //   onTap: () {
                //     print("Clicked");
                //     if (controller.speechToText.isListening) {
                //       controller.stopListening();
                //     } else {
                //       controller.startListening();
                //     }
                //   },
                //   child: Icon(
                //     Icons.mic,
                //   ),
                // ),
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
                    if (isEdit == false) {
                      controller.saveNoteApiCall();
                    } else {
                      controller.updateNoteApiCall();
                    }
                  }
                },
                text: (isEdit == true) ? 'Update' : 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
