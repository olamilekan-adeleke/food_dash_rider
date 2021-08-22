import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtomModalService {
  static void showModal(Widget child) {
    Get.bottomSheet(
      child,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      enableDrag: false,
      backgroundColor: Colors.grey,
    );
  }
}
