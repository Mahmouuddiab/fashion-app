import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<ServerException, Unit>> call(LoginEntity loginEntity) {
    return repository.login(loginEntity);
  }
}