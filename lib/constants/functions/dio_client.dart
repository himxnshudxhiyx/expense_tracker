import 'package:dio/dio.dart';
import 'package:expense_tracker/constants/functions/preference_manager.dart';
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
          // requestBody: true,
          // responseHeader: true,
          responseBody: true,
          error: true,
          showProcessingTime: true,
          // showCUrl: false,
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


  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params, bool? auth}) async {
    try {
      var options = Options();
      if (auth == true) {
        var authToken = await UserPreferences().getAuthToken() ?? '';
        options = Options(
          headers: {
            'Authorization': authToken,
          },
        );
      }
      var response = await _dio.get(url, queryParameters: params, options: options);
      return response.data;
    } catch (e) {
      if (e is DioError && e.response != null) {
        throw e.response!.data; // Throw the error response data
      }
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String url, {dynamic data, bool? auth}) async {
    try {
      var options = Options();
      if (auth == true) {
        var authToken = await UserPreferences().getAuthToken() ?? '';
        options = Options(
          headers: {
            'Authorization': authToken,
          },
        );
      }
      Response response = await _dio.post(url, data: data, options: options);
      return response.data;
    } catch (e) {
      if (e is DioError && e.response != null) {
        throw e.response!.data; // Throw the error response data
      }
      throw Exception('Failed to load data');
    }
  }

}