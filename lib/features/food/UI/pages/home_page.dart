import 'package:chowwe_rider/cores/constants/color.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/features/auth/model/user_details_model.dart';
import 'package:chowwe_rider/features/food/UI/pages/wallet_page.dart';
import 'package:chowwe_rider/features/food/repo/local_database_repo.dart';
import 'package:flutter/material.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/utils/sizer_utils.dart';

import 'package:chowwe_rider/features/food/UI/widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 10),
            const HeaderWidget(iconData: Icons.menu_outlined, title: 'Home'),
            SizedBox(height: sizerSp(10.0)),
            CircleAvatar(
              backgroundColor: kcPrimaryColor,
              radius: sizerSp(45),
              child: Icon(
                Icons.person,
                size: sizerSp(40),
                color: Colors.grey.shade100,
              ),
            ),
            SizedBox(height: sizerSp(20.0)),
            ValueListenableBuilder<RiderDetailsModel?>(
              valueListenable: LocaldatabaseRepo.userDetail,
              builder: (
                BuildContext context,
                RiderDetailsModel? user,
                Widget? child,
              ) {
                if (user == null) {
                  return Container();
                }

                return Column(
                  children: <Widget>[
                    CustomTextWidget(
                      text: user.fullName,
                      fontSize: sizerSp(14),
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextWidget(
                      text: user.email,
                      fontSize: sizerSp(13),
                      fontWeight: FontWeight.w200,
                    ),
                    CustomTextWidget(
                      text: user.phoneNumber.toString(),
                      fontSize: sizerSp(13),
                      fontWeight: FontWeight.w200,
                    ),
                    SizedBox(height: sizerSp(40.0)),
                    WalletOptionItemWidget(
                      title: 'I’m available for delivery',
                      callback: () => CustomNavigationService()
                          .navigateTo(RouteName.oderPageScreen),
                    ),
                    SizedBox(height: sizerSp(10.0)),
                    WalletOptionItemWidget(
                      title: 'Current Order',
                      callback: () => CustomNavigationService().navigateTo(
                        RouteName.currentOrders,
                        argument: user.uid,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
