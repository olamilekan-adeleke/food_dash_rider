import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/components/custom_textfiled.dart';
import 'package:chowwe_rider/cores/components/image_widget.dart';
import 'package:chowwe_rider/cores/constants/asset.dart';
import 'package:chowwe_rider/cores/constants/color.dart';
import 'package:chowwe_rider/cores/utils/emums.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/cores/utils/sizer_utils.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/validator.dart';
import 'package:chowwe_rider/features/auth/bloc/auth_bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static final TextEditingController emailTextEditingController =
      TextEditingController();
  static final TextEditingController passwordTextEditingController =
      TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      emailTextEditingController.text = 'ola1008@gmail.com';
      passwordTextEditingController.text = '123456';
    }
    return CustomScaffoldWidget(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: sizerWidth(100),
              height: sizerHeight(30),
              child: const CustomImageWidget(
                imageUrl: Assets.loginImagePng,
                imageTypes: ImageTypes.asset,
              ),
            ),
            Container(
              width: sizerWidth(100),
              height: sizerHeight(30),
              color: kcPrimaryColor.withOpacity(0.8),
            ),
            Positioned(
              top: sizerHeight(8),
              left: sizerSp(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextWidget(
                    text: 'Welcome Back',
                    textColor: Colors.white,
                    fontSize: sizerSp(30),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    text: 'Login to your account',
                    textColor: Colors.white,
                    fontSize: sizerSp(18),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Positioned(
              top: sizerHeight(25),
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: sizerSp(15)),
                alignment: Alignment.center,
                width: sizerWidth(30),
                height: sizerHeight(30),
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(sizerSp(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizerSp(15)),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 50.0),
                          CustomTextField(
                            textEditingController: emailTextEditingController,
                            hintText: 'Enter email address',
                            labelText: 'Email',
                            validator: (String? text) =>
                                formFieldValidator(text, 'Email', 3),
                          ),
                          const SizedBox(height: 20.0),
                          CustomTextField(
                            textEditingController:
                                passwordTextEditingController,
                            hintText: 'Enter Password',
                            labelText: 'Pasword',
                            isPassword: true,
                            validator: (String? text) =>
                                formFieldValidator(text, 'Password', 5),
                          ),
                          SizedBox(height: sizerSp(10.0)),
                          InkWell(
                            onTap: () => CustomNavigationService()
                                .navigateTo(RouteName.forgotPassword),
                            child: CustomTextWidget(
                              text: 'Forgot password?',
                              fontSize: sizerSp(10),
                              fontWeight: FontWeight.w600,
                              textColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: sizerHeight(60),
              right: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (BuildContext context, AuthState state) {
                      if (state is AuthLoginLoadedState) {
                        CustomSnackBarService.showSuccessSnackBar(
                            state.message);
                      } else if (state is AuthLoginErrorState) {
                        CustomSnackBarService.showErrorSnackBar(state.message);
                      }
                    },
                    builder: (BuildContext context, AuthState state) {
                      if (state is AuthLoginLoadingState) {
                        return const CustomButton.loading();
                      }

                      return CustomButton(
                        text: 'Log In',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginUserEvent(
                                email: emailTextEditingController.text.trim(),
                                password:
                                    passwordTextEditingController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: sizerSp(20.0)),
                  // InkWell(
                  //   onTap: () =>
                  //       CustomNavigationService().navigateTo(RouteName.signup),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       CustomTextWidget(
                  //         text: 'Not a member? ',
                  //         fontSize: sizerSp(11.24),
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //       CustomTextWidget(
                  //         text: 'Create and account',
                  //         fontSize: sizerSp(11.24),
                  //         fontWeight: FontWeight.w600,
                  //         textColor: Colors.red,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
