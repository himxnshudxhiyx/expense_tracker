import 'package:expense_tracker/modules/chatModule/models/all_user_api_response_model.dart';
import 'package:get/get.dart';

import '../../../constants/functions/api_manager.dart';

class ChatController extends GetxController {

  @override
  void onInit() {
    getAllUsersList();
    super.onInit();
  }

  RxBool getAllUserLoading = false.obs;

  RxList<AllUserListApiDataModel> allUsersList = <AllUserListApiDataModel>[].obs;

  getAllUsersList() async {
    try {
      getAllUserLoading.value = true;
      await ApiManager().get('auth/getAllUsers', auth: true).then((data) async {
        if (data['status'] == 200) {
          allUsersList.clear();
          var allUserListJson = AllUserListApiResponseModel.fromJson(data);
          allUsersList.addAll(allUserListJson.data ?? {});
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