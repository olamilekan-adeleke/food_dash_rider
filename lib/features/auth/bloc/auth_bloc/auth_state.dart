part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

class AuthInitial extends AuthState {}

//login states
class AuthLoginIntialState extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginLoadedState extends AuthState {
  const AuthLoginLoadedState(this.message);

  final String message;
}

class AuthLoginErrorState extends AuthState {
  const AuthLoginErrorState(this.message);

  final String message;
}

//sign up states
class AuthSignUpIntialState extends AuthState {}

class AuthSignUpLoadingState extends AuthState {}

class AuthSignUpLoadedState extends AuthState {
  const AuthSignUpLoadedState(this.message);

  final String message;
}

class AuthSignUpErrorState extends AuthState {
  const AuthSignUpErrorState(this.message);

  final String message;
}

//forgot password states
class AuthForgotPasswordIntialState extends AuthState {}

class AuthForgotPasswordLoadingState extends AuthState {}

class AuthForgotPasswordLoadedState extends AuthState {
  const AuthForgotPasswordLoadedState(this.message);

  final String message;
}

class AuthForgotPasswordErrorState extends AuthState {
  const AuthForgotPasswordErrorState(this.message);

  final String message;
}

//log out user states
class AuthLogOutUserIntialState extends AuthState {}

class AuthLogOutUserLoadingState extends AuthState {}

class AuthLogOutUserLoadedState extends AuthState {
  const AuthLogOutUserLoadedState(this.message);

  final String message;
}

class AuthLogOutUserErrorState extends AuthState {
  const AuthLogOutUserErrorState(this.message);

  final String message;
}

// edit user data
class UpdateUserDataIntialState extends AuthState {}

class UpdateUserDataLoadingState extends AuthState {}

class UpdateUserDataLoadedState extends AuthState {}

class UpdateUserDataErrorState extends AuthState {
  const UpdateUserDataErrorState(this.message);

  final String message;
}
