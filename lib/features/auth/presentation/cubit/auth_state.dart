abstract class AuthStates {}

class AuthInitialState extends AuthStates{}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates {}
class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState({required this.error});
}

class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState({required this.error});
}

class VerifyLoading extends AuthStates{}
class VerifySuccess extends AuthStates{}
class VerifyError extends AuthStates{
  String message;
  VerifyError({required this.message});
}