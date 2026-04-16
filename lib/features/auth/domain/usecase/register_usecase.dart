import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';
import 'package:fashion_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  AuthRepository repository;
  RegisterUseCase(this.repository);
  Future<Either<ServerException, Unit>> call(RegisterEntity registerEntity) =>
      repository.register(registerEntity);
}
