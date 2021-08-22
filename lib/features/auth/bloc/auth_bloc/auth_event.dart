part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

/// bloc event for loging in user. accept two required arguments which are
/// email(String) and password(String).
class LoginUserEvent extends AuthEvent {
  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

/// bloc event for siging up a new user, it requires 4 arguments, email,
/// password
/// and full name with are all of type <String> excpet number
/// which is a type of Int
class SignUpUserEvent extends AuthEvent {
  const SignUpUserEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.number,
    required this.dob,
  });

  final String email;
  final String password;
  final String fullName;
  final String dob;
  final int number;
}

/// bloc event for forgot password, accept email<String>
class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent(this.email);

  final String email;
}

// bloc event to log out user
class LogOutEvent extends AuthEvent {}

// update User data
class UpdateUserDataEvent extends AuthEvent {
  const UpdateUserDataEvent(this.userDetailsModel);
  final RiderDetailsModel userDetailsModel;

  
}
