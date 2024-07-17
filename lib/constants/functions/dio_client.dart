import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(); // Create Dio instance
    _setupInterceptors(); // Setup interceptors
  }

  void _setupInterceptors() {
    // Add interceptors for error handling, logging, etc.
    _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          queryParameters: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          showProcessingTime: true,
          showCUrl: true,
          canShowLog: kDebugMode,
        ),);
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (error, handler) {
    //       // Customize error handling here
    //       print('Dio Error: ${error.message}');
    //       // You can throw a custom exception or handle errors as needed
    //       return handler.next(error);
    //     },
    //     onRequest: (options, handler) {
    //       // Optional: Log request details, headers, etc.
    //       print('--> Method: ${options.method} URL: ${options.path}');
    //       print('--> Request ${options.data}');
    //       return handler.next(options);
    //     },
    //     onResponse: (response, handler) {
    //       // Optional: Log response details, status code, etc.
    //       print('<-- Status Code: ${response.statusCode}');
    //       return handler.next(response);
    //     },
    //   ),
    // );
  }

  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params}) async {
    try {
      var response = await _dio.get(url, queryParameters: params);
      return response.data;
    } catch (e) {
      print('Error occurred in GET request: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String url, {dynamic data}) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response.data;
    } catch (e) {
      print('Error occurred in POST request: $e');
      throw Exception('Failed to load data');
    }
  }

}