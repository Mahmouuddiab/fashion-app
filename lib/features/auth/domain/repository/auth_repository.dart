import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';

abstract class AuthRepository {

  Future<Either<ServerException, Unit>> register(
      RegisterEntity registerEntity,
      );

  Future<Either<ServerException, Unit>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<ServerException, Unit>> login(
      LoginEntity loginEntity,
      );
}