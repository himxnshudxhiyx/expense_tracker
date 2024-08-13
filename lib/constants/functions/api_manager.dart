import 'dio_client.dart';

class ApiManager {
  final DioClient _dioClient = DioClient(); // Instance of DioClient

  String baseUrl = "https://notes-node-theta.vercel.app/api/";

  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params, bool? auth}) async {
    try {
      var response = await _dioClient.get("${baseUrl}$url", params: params, auth: auth);
      return response;
    } catch (e) {
      if (e is Map<String, dynamic>) {
        return e; // Return the error response data
      }
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String url, {dynamic body, bool? auth}) async {
    try {
      var response = await _dioClient.post("${baseUrl}$url", data: body, auth: auth);
      return response;
    } catch (e) {
      if (e is Map<String, dynamic>) {
        return e; // Return the error response data
      }
      throw Exception('Failed to load data$e');
    }
  }
}