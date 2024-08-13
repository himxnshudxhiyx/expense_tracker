import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';
import '../../../constants/functions/flutter_error.dart';
import '../../../constants/functions/preference_manager.dart';
import '../../login/models/login_api_response_model.dart';

class MessageController extends GetxController {
  @override
  void onInit() {
    getDataFromPreviousScreen();
    super.onInit();
  }

  String phoneNumber = '';
  String emailId = '';
  RxString personName = ''.obs;

  Rx<UserDetails> userDetails = UserDetails().obs;

  getSavedData() async {
    try {
      String data = await UserPreferences().getUserData() ?? "";
      var userData = jsonDecode(data);
      userDetails.value = UserDetails.fromJson(userData);
      userDetails.refresh();
      checkChatRoomExist();
    } catch (e, stack) {
      printFlutterError(error: e, stack: stack, runTimeType: runtimeType);
    }
  }

  RxString chatRoomId = ''.obs;

  checkChatRoomExist() async {
    try {
      List<String> phoneNumbers = [userDetails.value.phoneNumber.toString(), phoneNumber.toString()];

      // Sort the list
      phoneNumbers.sort();

      // Join the sorted list with '_'
      String sortedJoined = phoneNumbers.join('_');

      var request = {
        // 'chatRoomId': '${userDetails.value.phoneNumber}_$phoneNumber',

      // Sort the list and join with '_'
        'chatRoomId':sortedJoined,

      };
      await ApiManager().post('chat/chatRoomExists', body: request, auth: true).then((data) async {
        if (data['status'] == 200){
          if(data['exists'] == true) {
            chatRoomId.value = sortedJoined;
            return;
          } else {
            createChatRoomApi(emailId: emailId, phoneNumber: phoneNumber);
          }
        }
        // var userData = await UserPreferences().getUserData();
        // print("UserData${ jsonDecode(userData.toString()) }");
      });
      // print('GET Response: ${getResponse.data}');
    } catch (e, stack) {
      printFlutterError(runTimeType: runtimeType, stack: stack, error: e.toString());
    }
  }

  getDataFromPreviousScreen(){
    if (Get.arguments != null) {
      personName.value = Get.arguments['personName'];
      emailId = Get.arguments['emailId'];
      phoneNumber = Get.arguments['phoneNumber'];
      getSavedData();
    }
  }

  createChatRoomApi({emailId, phoneNumber}) async {
    try {
      var request = {
        'chatWithUserEmail': emailId,
        'chatWithUserPhone': phoneNumber,
        'loggedInUserEmail': userDetails.value.username,
        'loggedInUserPhone': userDetails.value.phoneNumber,
      };
      await ApiManager().post('chat/createChatRoom', body: request, auth: true).then((data) async {
        if (data['status'] == 201){
          chatRoomId.value = data['chatRoomId'];
        }
        // var userData = await UserPreferences().getUserData();
        // print("UserData${ jsonDecode(userData.toString()) }");
      });
      // print('GET Response: ${getResponse.data}');
    } catch (e, stack) {
      printFlutterError(runTimeType: runtimeType, stack: stack, error: e.toString());
    }
  }

  sendNotification({message}) async {
    try {
      var request = {
        'userEmail': emailId,
        'message': message,
        'from': '${userDetails.value.firstName} ${userDetails.value.lastName}',
      };
      await ApiManager().post('chat/sendNotification', body: request, auth: true).then((data) async {
       });
    } catch (e, stack) {
      printFlutterError(runTimeType: runtimeType, stack: stack, error: e.toString());
    }
  }

  Map<String, List<QueryDocumentSnapshot>> groupMessagesByDate(List<QueryDocumentSnapshot> messages) {
    Map<String, List<QueryDocumentSnapshot>> groupedMessages = {};

    for (var message in messages) {
      final timestamp = message['timestamp'].toDate();
      final dateString = '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';

      if (!groupedMessages.containsKey(dateString)) {
        groupedMessages[dateString] = [];
      }
      groupedMessages[dateString]!.add(message);
    }

    return groupedMessages;
  }
}