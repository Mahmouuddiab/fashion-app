import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';
import 'package:fashion_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDs remote;
  AuthRepositoryImpl(this.remote);
  @override
  Future<Either<ServerException, Unit>> register(RegisterEntity registerEntity) async{
    await remote.register(registerEntity);
    return Right(unit);
  }

  @override
  Future<Either<ServerException, Unit>> verifyEmail({required String email, required String otp}) async{
    await remote.verifyEmail(email: email, otp: otp);
    return Right(unit);
  }

  @override
  Future<Either<ServerException, Unit>> login(LoginEntity loginEntity) async{
    await remote.login(loginEntity);
    return Right(unit);
  }
}