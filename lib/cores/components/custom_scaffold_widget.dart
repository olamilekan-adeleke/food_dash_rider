import 'package:flutter/material.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({Key? key, required this.body, this.appBar})
      : super(key: key);

  final Widget body;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        body: body,
      ),
    );
  }
}
