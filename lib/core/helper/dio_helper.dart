import 'package:dio/dio.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  static Dio? _dio;


  DioHelper._internal() {
    BaseOptions baseOptions = BaseOptions(
      receiveDataWhenStatusError: true,
      contentType: "application/json",
    );


    _dio = Dio(baseOptions);
    // Add interceptors
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Include the Content-Type header for every request
        options.headers["Content-Type"] = "application/json";
        return handler.next(options);
      },
    ));

  }

  static Future<Response> _handleError(DioException e) {
    if (e.response != null) {
      debugPrint('Response data: ${e.response!.data}');
      debugPrint('Status code: ${e.response!.statusCode}');
      switch (e.response!.statusCode) {
        case 400:
          throw InvalidCredentialsException(e.response!.data['message']);
        case 401:
          throw InvalidCredentialsException(AppStrings.errorUnauthorized);
        case 403:
          throw ServerException(AppStrings.errorForbidden);
        case 404:
          throw ServerException(AppStrings.errorResource);
        case 429:
          throw ServerException(AppStrings.errorServer);
        case 500:
          throw ServerException(AppStrings.errorInternal);
        default:
          throw ServerException(
              'Server error: ${e.response!.statusCode} ${e.response!.statusMessage}');
      }
    } else {
      debugPrint('Network error: ${e.message}');
      throw NetworkException(AppStrings.errorNetwork);
    }
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Options? options
  }) async {
    try {
      Response response = await _dio!.post(url, data: data,options: options);
      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }    }
  }

  static Future<Response> getData({
    required String ?url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useCache = true,
  }) async {
    try {
      Response response = await _dio!.get(
          url!,
          queryParameters: queryParameters,
          options: options
      );

      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }
    }
  }


  static Future<Response> putData({
    required String url,
    required dynamic data,
  }) async {
    try {
      Response response = await _dio!.put(url, data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }
    }
  }

  static Future<Response> deleteData({
    required String url,
    Options? options,
    Map<String, dynamic>? queryParameters
  }) async {
    try {
      Response response = await _dio!.delete(url,options: options,queryParameters: queryParameters);
      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }
}