import 'package:chowwe_rider/features/auth/model/user_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/components/custom_textfiled.dart';
import 'package:chowwe_rider/cores/constants/color.dart';
import 'package:chowwe_rider/cores/utils/sizer_utils.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/validator.dart';
import 'package:chowwe_rider/features/auth/bloc/auth_bloc/auth_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static final TextEditingController emailTextEditingController =
      TextEditingController();
  static final TextEditingController passwordTextEditingController =
      TextEditingController();
  static final TextEditingController firstNameTextEditingController =
      TextEditingController();
  static final TextEditingController lastNameTextEditingController =
      TextEditingController();
  static final TextEditingController numberTextEditingController =
      TextEditingController();
  static final TextEditingController dobTextEditingController =
      TextEditingController();
  static final TextEditingController companyNameEditingController =
      TextEditingController();
  static final TextEditingController companyContactEditingController =
      TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void pickDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 15),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year - 15),
    );

    if (picked != null) {
      dobTextEditingController.text = picked.toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      emailTextEditingController.text = 'ola200@gmail.com';
      passwordTextEditingController.text = '123456';
      firstNameTextEditingController.text = 'ola';
      lastNameTextEditingController.text = 'rider';
      numberTextEditingController.text = '09088776655';
      companyNameEditingController.text = 'Jolobbi Company';
      companyContactEditingController.text = '07052936789';
    }

    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizerSp(15),
          vertical: sizerSp(10),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50.0),
                CustomTextWidget(
                  text: 'Create your \naccount',
                  fontSize: sizerSp(28),
                  textColor: kcPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 50.0),
                CustomTextField(
                  textEditingController: firstNameTextEditingController,
                  hintText: 'Enter first name',
                  labelText: 'First Name',
                  validator: (String? text) =>
                      formFieldValidator(text, 'First Name', 2),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: lastNameTextEditingController,
                  hintText: 'Enter last name',
                  labelText: 'Last Name',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Last Name', 2),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  hintText: 'Enter email address',
                  labelText: 'Email',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Email', 3),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: numberTextEditingController,
                  hintText: 'Enter Phone Number',
                  labelText: 'Phone Number',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Phone Number', 10),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () => pickDateTime(context),
                  child: CustomTextField(
                    textEditingController: dobTextEditingController,
                    hintText: 'Enter Date of Birth',
                    labelText: 'dob',
                    enable: false,
                    validator: (String? text) =>
                        formFieldValidator(text, 'dob', 5),
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: companyNameEditingController,
                  hintText: 'Enter Company Name',
                  labelText: 'Company Name',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Company Name', 2),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: companyContactEditingController,
                  hintText: 'Enter Company Phone Number',
                  labelText: 'Company Phone Number',
                  validator: (String? text) =>
                      formFieldValidator(text, 'Company Phone Number', 10),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  hintText: 'Enter Password',
                  labelText: 'Password',
                  isPassword: true,
                  validator: (String? text) =>
                      formFieldValidator(text, 'Password', 5),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    CustomTextWidget(
                      text: 'By signing up, you agree to our ',
                      fontSize: sizerSp(11),
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text: 'Terms And Conditions',
                      fontSize: sizerSp(11),
                      fontWeight: FontWeight.w600,
                      textColor: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) {
                    if (state is AuthSignUpLoadedState) {
                      CustomSnackBarService.showSuccessSnackBar(state.message);
                      CustomNavigationService().goBack();
                    } else if (state is AuthSignUpErrorState) {
                      CustomSnackBarService.showErrorSnackBar(state.message);
                    }
                  },
                  builder: (BuildContext context, AuthState state) {
                    if (state is AuthSignUpLoadingState) {
                      return const CustomButton.loading();
                    }

                    return CustomButton(
                      text: 'Sign Up',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          final String fullName =
                              '${firstNameTextEditingController.text.trim()}'
                              ' ${lastNameTextEditingController.text.trim()}';
                          BlocProvider.of<AuthBloc>(context).add(
                            SignUpUserEvent(
                              email: emailTextEditingController.text.trim(),
                              password:
                                  passwordTextEditingController.text.trim(),
                              fullName: fullName,
                              number: int.parse(
                                  numberTextEditingController.text.trim()),
                              dob: dobTextEditingController.text,
                              company: CompanyData(
                                companyName:
                                    companyNameEditingController.text.trim(),
                                companyContact:
                                    companyContactEditingController.text.trim(),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () => CustomNavigationService().goBack(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextWidget(
                        text: 'Already have an account? ',
                        fontSize: sizerSp(12),
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextWidget(
                        text: 'Login',
                        fontSize: sizerSp(12),
                        fontWeight: FontWeight.w600,
                        textColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
