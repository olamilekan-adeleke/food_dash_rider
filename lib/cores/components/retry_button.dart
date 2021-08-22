import 'package:flutter/material.dart';
import '../components/custom_text_widget.dart';

class RetryButtonWidget extends StatelessWidget {
  const RetryButtonWidget({Key? key, this.callback}) : super(key: key);

  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback!.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const CustomTextWidget(
          text: 'Retry',
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
