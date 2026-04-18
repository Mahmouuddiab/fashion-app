import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/core/helper/cache_helper.dart';
import 'package:fashion_app/core/helper/dio_helper.dart';
import 'package:fashion_app/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:fashion_app/features/auth/data/models/login_model.dart';
import 'package:fashion_app/features/auth/data/models/otp_model.dart';
import 'package:fashion_app/features/auth/data/models/register_model.dart';
import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  @override
  Future<Unit> register(RegisterEntity registerEntity) async {
    try {
      final response = await DioHelper.postData(
        url: "https://accessories-eshop.runasp.net/api/auth/register",
        data: {
          "email": registerEntity.email,
          "password": registerEntity.password,
          "firstName": registerEntity.firstName,
          "lastName": registerEntity.lastName,
        },
      );

      final data = response.data;

      final user = _safeRegisterModel(data);

      print("REGISTER MESSAGE: ${user.message}");

      return unit;
    } on DioException catch (e) {
      _handleError(e, "Register failed");
      rethrow;
    }
  }

  @override
  Future<Unit> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: "https://accessories-eshop.runasp.net/api/auth/verify-email",
        data: {
          "email": email,
          "otp": otp,
        },
      );

      final data = response.data;

      final verify = _safeOtpModel(data);

      print("VERIFY MESSAGE: ${verify.message}");

      return unit;
    } on DioException catch (e) {
      _handleError(e, "Verification failed");
      rethrow;
    }
  }

  // ================= SAFE PARSERS =================

  RegisterModel _safeRegisterModel(dynamic data) {
    if (data is Map<String, dynamic>) {
      return RegisterModel.fromJson(data);
    }
    return RegisterModel(message: data.toString());
  }

  OtpModel _safeOtpModel(dynamic data) {
    if (data is Map<String, dynamic>) {
      return OtpModel.fromJson(data);
    }
    return OtpModel(
      statusCode: null,
      message: data.toString(),
    );
  }

  void _handleError(DioException e, String fallback) {
    print("ERROR STATUS: ${e.response?.statusCode}");
    print("ERROR DATA: ${e.response?.data}");

    final error = e.response?.data;

    throw Exception(
      (error is Map<String, dynamic>)
          ? error["message"] ?? fallback
          : fallback,
    );
  }

  @override
  Future<Unit> login(LoginEntity loginEntity) async {
    try {
      final response = await DioHelper.postData(
        url: "https://accessories-eshop.runasp.net/api/auth/login",
        data: {
          "email": loginEntity.email,
          "password": loginEntity.password,
        },
      );

      final user = LoginModel.fromJson(response.data);
      final token = user.accessToken;
      await CacheHelper.saveToken(token);
      print("user token: $token");

      return unit;
    } on DioException catch (e) {
      _handleError(e, "Login failed");
      rethrow;
    }
  }
}