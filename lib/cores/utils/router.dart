import 'package:chowwe_rider/features/food/UI/pages/current_orders_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/eidt_profile_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/oder_history_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/order_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/profile_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/selected_order_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/verify_rider_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/wallet_page.dart';
import 'package:chowwe_rider/features/food/UI/pages/withdrawal_history_screen.dart';
import 'package:chowwe_rider/features/food/model/order_model.dart';
import 'package:flutter/material.dart';

import 'package:chowwe_rider/cores/components/error_navigation_wiget.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/features/auth/UI/pages/forgot_password_page.dart';
import 'package:chowwe_rider/features/auth/UI/pages/login.dart';
import 'package:chowwe_rider/features/auth/UI/pages/sig_up_page.dart';
import 'package:chowwe_rider/features/auth/UI/pages/wrapper_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.inital:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const WrapperPage());

    case RouteName.login:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const LoginPage());

    case RouteName.signup:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const SignUpPage());

    case RouteName.forgotPassword:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const ForgotPasswordPage());

    case RouteName.profileScreen:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const ProfileScreen());

    case RouteName.editAddress:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const EditprofileScreen());

    case RouteName.oderHistoryScreen:
      if (settings.arguments is String) {
        final String id = settings.arguments as String;

        return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => OrderHistoryScreen(id));
      }

      break;

    case RouteName.withdrawalHistoryScreen:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const WithdrawalHistoryScreen());

    case RouteName.wallet:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const WalletScreen());

    case RouteName.oderPageScreen:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const OrderScreen());

    case RouteName.selectedOderScreen:
      if (settings.arguments is OrderModel) {
        final OrderModel order = settings.arguments as OrderModel;

        return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => SelectedOrderScreen(order));
      }
      break;

    case RouteName.verifyRiderScreen:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const VerifyRiderScreen());

    case RouteName.currentOrders:
      if (settings.arguments is String) {
        final String id = settings.arguments as String;

        return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => CurrentOrders(id));
      }
      break;

    default:
      return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const ErrornavigationWidget());
  }
}
