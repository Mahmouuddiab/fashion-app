import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/error/exception.dart';
import 'package:fashion_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<ServerException, Unit>> call({
    required String email,
    required String otp,
  }) {
    return repository.verifyEmail(
      email: email,
      otp: otp,
    );
  }
}