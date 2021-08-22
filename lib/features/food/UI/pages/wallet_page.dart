import 'dart:developer';

import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/components/custom_textfiled.dart';
import 'package:chowwe_rider/cores/constants/color.dart';
import 'package:chowwe_rider/cores/utils/buttom_modal.dart';
import 'package:chowwe_rider/cores/utils/locator.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/cores/utils/sizer_utils.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/features/auth/model/user_details_model.dart';
import 'package:chowwe_rider/features/food/UI/widgets/header_widget.dart';
// import 'package:chowwe_rider/features/food/repo/food_repo.dart';
import 'package:chowwe_rider/features/food/repo/local_database_repo.dart';
import 'package:chowwe_rider/features/payment/repo/payment_repo.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10)),
        child: Column(
          children: <Widget>[
            SizedBox(height: sizerSp(10)),
            const HeaderWidget(iconData: Icons.menu, title: 'Wallet'),
            SizedBox(height: sizerSp(20)),
            const WalletBalanceWidget(),
            SizedBox(height: sizerSp(20)),
            WalletOptionItemWidget(
              title: 'Withdraw my earnings',
              callback: () {},
              color: Colors.white,
            ),
            SizedBox(height: sizerSp(10)),
            WalletOptionItemWidget(
              title: 'Add my bank account',
              callback: () {},
              // color: Colors,
            ),
            SizedBox(height: sizerSp(10)),
            WalletOptionItemWidget(
              title: 'Withdrawal History',
              callback: () => CustomNavigationService()
                  .navigateTo(RouteName.withdrawalHistoryScreen),
            ),
          ],
        ),
      ),
    );
  }
}

class FundWalletDetailsWidget extends StatelessWidget {
  const FundWalletDetailsWidget({
    Key? key,
  }) : super(key: key);

  static final PaymentRepo paymentRepo = locator<PaymentRepo>();
  static final LocaldatabaseRepo localdatabaseRepo =
      locator<LocaldatabaseRepo>();
  static final TextEditingController textEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sizerSp(10)),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextWidget(
            text: 'Amount',
            fontSize: sizerSp(16.0),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            textEditingController: textEditingController,
            hintText: 'Enter Amount',
            labelText: 'Amount',
            textInputType: TextInputType.number,
          ),
          SizedBox(height: sizerSp(20)),
          CustomTextWidget(
            text: 'Seelct Payment Type',
            fontSize: sizerSp(16.0),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: sizerSp(20)),
          InkWell(
            onTap: () async {
              if (textEditingController.text.trim().isEmpty) {
                CustomSnackBarService.showWarningSnackBar(
                    'Please Enter Amount!');
                return;
              }
              paymentRepo.chargeCard(
                price: int.parse(textEditingController.text.trim()),
                context: context,
                userEmail:
                    (await localdatabaseRepo.getUserDataFromLocalDB())!.email,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  text: 'Card',
                  fontSize: sizerSp(16.0),
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          SizedBox(height: sizerSp(10)),
          InkWell(
            onTap: () async {
              if (textEditingController.text.trim().isEmpty) {
                CustomSnackBarService.showWarningSnackBar(
                    'Please Enter Amount!');
                return;
              }
              paymentRepo.chargeBank(
                price: int.parse(textEditingController.text.trim()),
                context: context,
                userEmail:
                    (await localdatabaseRepo.getUserDataFromLocalDB())!.email,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  text: 'Bank Transfer',
                  fontSize: sizerSp(16.0),
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          SizedBox(height: sizerSp(40)),
        ],
      ),
    );
  }
}

class WalletOptionItemWidget extends StatelessWidget {
  const WalletOptionItemWidget({
    Key? key,
    required this.title,
    required this.callback,
    this.color = kcPrimaryColor,
  }) : super(key: key);

  final String title;
  final void Function() callback;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizerWidth(80),
      height: sizerSp(50),
      child: InkWell(
        onTap: () => callback(),
        child: Card(
          elevation: 5.0,
          child: Container(
            color: color,
            child: Center(
              child: CustomTextWidget(
                text: title,
                textColor:
                    color == kcPrimaryColor ? Colors.white : Colors.black,
                fontSize: sizerSp(12.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({Key? key}) : super(key: key);

  static final RiderRepo riderRepo = locator<RiderRepo>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: riderRepo.userWalletStream(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final RiderDetailsModel userDetails = RiderDetailsModel.fromMap(
          snapshot.data!.data() ?? <String, dynamic>{},
        );
        return Container(
          padding: EdgeInsets.all(sizerSp(10.0)),
          width: sizerWidth(80),
          height: sizerSp(130),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizerSp(10.0)),
            color: kcPrimaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextWidget(
                text: 'Wallet Balance',
                textColor: Colors.white,
                fontSize: sizerSp(16.0),
              ),
              SizedBox(height: sizerSp(10.0)),
              CustomTextWidget(
                text: '\u20A6 ${userDetails.walletBalance.toString()}',
                textColor: Colors.white,
                fontSize: sizerSp(20.0),
                fontWeight: FontWeight.bold,
              ),
              // SizedBox(height: sizerSp(5.0)),
              CustomTextWidget(
                text: userDetails.fullName,
                textColor: Colors.white,
                fontSize: sizerSp(15.0),
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        );
      },
    );
  }
}
