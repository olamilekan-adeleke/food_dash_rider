import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_textfiled.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/validator.dart';
import 'package:chowwe_rider/features/auth/bloc/auth_bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController emailTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 250.0,
                  child: Placeholder(),
                ),
                const SizedBox(height: 50.0),
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  hintText: 'Enter email address',
                  labelText: 'Email',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Email', 3),
                ),
                const SizedBox(height: 80.0),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) {
                    if (state is AuthForgotPasswordLoadedState) {
                      CustomSnackBarService.showSuccessSnackBar(state.message);
                    } else if (state is AuthForgotPasswordErrorState) {
                      CustomSnackBarService.showErrorSnackBar(state.message);
                    }
                  },
                  builder: (BuildContext context, AuthState state) {
                    if (state is AuthForgotPasswordLoadingState) {
                      return const CustomButton.loading();
                    }

                    return CustomButton(
                      text: 'Forgot Password',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            ForgotPasswordEvent(
                                emailTextEditingController.text.trim()),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () => CustomNavigationService().goBack(),
                  child: const Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
