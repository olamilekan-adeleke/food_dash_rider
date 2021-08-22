import 'package:flutter/material.dart';

void errorLog(String error, String info, {String? trace, String? title}) {
  debugPrint('${':' * 10} Error $title ${':' * 10}');
  debugPrint('Error: $error \n Info: $info \n Trace: $trace');
  debugPrint('${':' * 10} ${':' * 10}');
}

void infoLog(String info, {String? message, String? title}) {
  debugPrint('${':' * 10} Begin $title ${':' * 10}');
  debugPrint('Info: $info \n message: $message \n Title: $title');
  debugPrint('${':' * 10} End $title ${':' * 10}');
}
