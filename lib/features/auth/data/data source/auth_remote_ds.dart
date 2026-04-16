import 'package:dartz/dartz.dart';
import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';

abstract class AuthRemoteDs {
  Future<Unit> register(RegisterEntity registerEntity);

  Future<Unit> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Unit> login(LoginEntity loginEntity);
}