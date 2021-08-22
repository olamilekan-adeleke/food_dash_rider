import 'package:flutter/material.dart';
import 'package:chowwe_rider/cores/utils/locator.dart';
import 'package:stacked_services/stacked_services.dart';


class CustomNavigationService {
  static final NavigationService _navigationService =
      locator<NavigationService>();

  Future<dynamic>? navigateTo(String routeName, {dynamic argument}) {
    debugPrint(routeName);

    return _navigationService.navigateTo(routeName, arguments: argument);
  }

  Future<dynamic>? navigateRecplace(String routeName, {dynamic argument}) {
    debugPrint(routeName);
    return _navigationService.replaceWith(routeName, arguments: argument);
  }

  bool goBack() {
    return _navigationService.back();
  }
}
