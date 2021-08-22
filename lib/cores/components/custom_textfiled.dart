import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../utils/sizer_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.autoCorrect = true,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.maxLine = 1,
    this.enable,
    this.ontap,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool autoCorrect;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isPassword;
  final int? maxLine;
  final bool? enable;
  final Function()? ontap;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return TextFormField(
          enabled: widget.enable,
          maxLines: widget.maxLine,
          cursorColor: kcPrimaryColor,
          style: GoogleFonts.raleway(),
          controller: widget.textEditingController,
          autocorrect: widget.autoCorrect,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(sizerSp(5.0)),
            ),
            hintText: widget.hintText,
            // labelText: widget.labelText,
            suffixIcon: widget.isPassword == false
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () => obscureText.value = !obscureText.value,
                  ),
          ),
          keyboardType: widget.textInputType,
          obscureText: value,
          validator: (String? val) => widget.validator!(val?.trim()),
          onTap: () => widget.ontap!(),
        );
      },
    );
  }
}
