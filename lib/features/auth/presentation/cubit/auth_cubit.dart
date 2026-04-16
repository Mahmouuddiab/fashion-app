import 'package:fashion_app/features/auth/domain/entity/login_entity.dart';
import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';
import 'package:fashion_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:fashion_app/features/auth/domain/usecase/register_usecase.dart';
import 'package:fashion_app/features/auth/domain/usecase/verify_email_usecase.dart';
import 'package:fashion_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  final RegisterUseCase registerUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit(
      this.registerUseCase,
      this.verifyEmailUseCase,
      this.loginUseCase,
      ) : super(AuthInitialState());

  /// REGISTER
  Future<void> register(RegisterEntity registerEntity) async {
    emit(RegisterLoadingState());

    final response = await registerUseCase.call(registerEntity);

    response.fold(
          (failure) {
        emit(RegisterErrorState(
          error: "Can't register: ${failure.message}",
        ));
      },
          (_) {
        emit(RegisterSuccessState());
      },
    );
  }

  /// Login
  Future<void> login(LoginEntity loginEntity) async {
    emit(LoginLoadingState());

    final response = await loginUseCase.call(loginEntity);

    response.fold(
          (failure) {
        emit(LoginErrorState(
          error: "Can't login: ${failure.message}",
        ));
      },
          (_) {
        emit(LoginSuccessState());
      },
    );
  }

  /// VERIFY
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    emit(VerifyLoading());

    final response = await verifyEmailUseCase.call(
      email: email,
      otp: otp,
    );

    response.fold(
          (failure) {
        emit(VerifyError(
          message: "Can't verify: ${failure.message}",
        ));
      },
          (_) {
        emit(VerifySuccess());
      },
    );
  }
}