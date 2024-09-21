import 'package:expense_tracker/modules/chatModule/models/all_user_api_response_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getContactList();
    getAllUsersList();
    super.onInit();
  }

  RxBool getAllUserLoading = false.obs;

  RxList<AllUserListApiDataModel> allUsersList =
      <AllUserListApiDataModel>[].obs;

  RxList<String> contacts = <String>[].obs;

  getContactList() async {
    List<Contact> tempContacts = await FlutterContacts.getContacts();

    for (var element in tempContacts) {
      if (element.phones.isNotEmpty) {
        contacts.add(element.phones[0].toString().replaceAll("+91", ''));
      }
    }
  }

  getAllUsersList() async {
    try {
      getAllUserLoading.value = true;
      await ApiManager().get('auth/getAllUsers', auth: true).then((data) async {
        if (data['status'] == 200) {
          allUsersList.clear();
          var allUserListJson = AllUserListApiResponseModel.fromJson(data);

          List<AllUserListApiDataModel> allUserData = [];
          allUserData.addAll(allUserListJson.data ?? {});
          // allUserData.forEach((e) {
          //   if(contacts.contains(e.phoneNumber.toString().replaceAll('+91', ''))){
          //     allUsersList.add(e);
          //   }
          // });
          allUsersList.addAll(allUserData);
          // allUsersList.addAll(allUserListJson.data ?? {});
          allUsersList.refresh();
          getAllUserLoading.value = false;
        } else {
          allUsersList.clear();
          getAllUserLoading.value = false;
        }
      });
    } catch (e, stack) {
      getAllUserLoading.value = false;
      print('Error occurred: $e');
      print('Stack where occurred: $stack');
    }
  }
}
