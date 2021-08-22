import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chowwe_rider/features/auth/model/user_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:chowwe_rider/cores/constants/success_text.dart';
import 'package:chowwe_rider/features/auth/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  final AuthenticationRepo authenticationRepo =
      GetIt.instance<AuthenticationRepo>();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      try {
        yield AuthLoginLoadingState();
        await authenticationRepo.loginUserWithEmailAndPassword(
          event.email,
          event.password,
        );
        yield const AuthLoginLoadedState(loginSucessMessage);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield AuthLoginErrorState(e.toString());
      }
    } else if (event is SignUpUserEvent) {
      try {
        yield AuthSignUpLoadingState();
        await authenticationRepo.registerUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
          fullName: event.fullName,
          number: event.number,
          dob: event.dob,
        );
        yield const AuthSignUpLoadedState(signUpSucessMessage);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield AuthSignUpErrorState(e.toString());
      }
    } else if (event is ForgotPasswordEvent) {
      try {
        yield AuthForgotPasswordLoadingState();
        await authenticationRepo.resetPassword(event.email);
        yield const AuthForgotPasswordLoadedState(forgotPasswordSucessMessage);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield AuthForgotPasswordErrorState(e.toString());
      }
    } else if (event is LogOutEvent) {
      try {
        yield AuthLogOutUserLoadingState();
        await authenticationRepo.signOut();
        yield const AuthLoginLoadedState(logOutSuccessText);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield AuthLogOutUserErrorState(e.toString());
      }
    } else if (event is UpdateUserDataEvent) {
      try {
        yield UpdateUserDataLoadingState();
        await authenticationRepo.updateUserData(event.userDetailsModel);
        yield UpdateUserDataLoadedState();
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield UpdateUserDataErrorState(e.toString());
      }
    }
  }
}
