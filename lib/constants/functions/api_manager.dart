import 'dart:convert';



import 'dio_client.dart'; // Import DioClient class
import 'package:dio/dio.dart';

class ApiManager {
  final DioClient _dioClient = DioClient(); // Instance of DioClient

  String baseUrl = "https://notes-node-rho.vercel.app/api/";

  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params, bool? auth}) async {
    try {
      var response = await _dioClient.get("${baseUrl}$url", params: params, auth: auth);
      return response;
    } catch (e) {
      print('Error occurred in GET request: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String url, {dynamic body}) async {
    try {
      var response = await _dioClient.post("${baseUrl}$url", data: body);
      return response;
    } catch (e, stack) {
      print('Error occurred in POST request: $e');
      print('Stack occurred in POST request: $stack');
      throw Exception('Failed to load data');
    }
  }

// Add more methods as needed for other HTTP methods (PUT, DELETE, etc.)
}