import 'package:flutter/material.dart';
import 'package:chowwe_rider/features/auth/UI/pages/login.dart';
import 'package:chowwe_rider/features/auth/model/login_user_model.dart';
import 'package:chowwe_rider/features/auth/repo/auth_repo.dart';
import 'package:chowwe_rider/features/food/UI/pages/home_tab_pages.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({Key? key}) : super(key: key);

  static final AuthenticationRepo authenticationRepo =
      GetIt.instance<AuthenticationRepo>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LoginUserModel?>.value(
      initialData: null,
      value: authenticationRepo.userAuthState,
      builder: (BuildContext context, Widget? child) {
        return const AuthStateWidget();
      },
    );
  }
}

class AuthStateWidget extends StatelessWidget {
  const AuthStateWidget();

  @override
  Widget build(BuildContext context) {
    Widget widget;
    final LoginUserModel? loginUserModel =
        Provider.of<LoginUserModel?>(context, listen: true);

    if (loginUserModel == null) {
      widget = const LoginPage();
    } else {
      

      widget = const HomeTabScreen();
    }

    return Scaffold(body: widget);
  }
}
