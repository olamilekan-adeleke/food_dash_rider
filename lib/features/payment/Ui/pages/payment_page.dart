import 'package:flutter/material.dart';
import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/constants/font_size.dart';
import 'package:chowwe_rider/cores/utils/emums.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/features/food/repo/local_database_repo.dart';
import 'package:chowwe_rider/features/payment/repo/payment_repo.dart';
import 'package:get_it/get_it.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static final ValueNotifier<PaymentType> paymentType =
      ValueNotifier<PaymentType>(PaymentType.none);

  static final LocaldatabaseRepo localdatabaseRepo =
      GetIt.instance<LocaldatabaseRepo>();

  static final PaymentRepo paymentRepo = GetIt.instance<PaymentRepo>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'Payment Page',
          fontWeight: FontWeight.bold,
          fontSize: kfsSuperLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => CustomNavigationService().goBack(),
          color: Colors.black,
        ),
      ),
      body: ValueListenableBuilder<PaymentType>(
        valueListenable: paymentType,
        builder: (BuildContext context, PaymentType value, Widget? child) {
          return Column(
            children: <Widget>[
              PaymentOptionItem(
                text: 'Card',
                subTitle: 'Make payment using your credit card',
                selected: value == PaymentType.card,
                callback: () => paymentType.value = PaymentType.card,
              ),
              PaymentOptionItem(
                text: 'Cash',
                subTitle: 'Pay on delivery',
                selected: value == PaymentType.cash,
                callback: () => paymentType.value = PaymentType.cash,
              ),
              PaymentOptionItem(
                text: 'Transfer',
                subTitle: 'Bank Transfer',
                selected: value == PaymentType.transfer,
                callback: () => paymentType.value = PaymentType.transfer,
              ),
              const Spacer(),
              CustomButton(
                text: 'Next',
                onTap: () async {
                  // final List<CartModel> cartItems =
                  //     await localdatabaseRepo.getAllItemInCart();

                  // int allProductPrice = 0;

                  // for (final CartModel cart in cartItems) {
                  //   allProductPrice =
                  //       allProductPrice + (cart.price * cart.count);
                  // }

                  switch (paymentType.value) {
                    case PaymentType.card:
                      break;
                    case PaymentType.cash:
                      paymentRepo.chargeCard(
                        price: 0,
                        context: context,
                        userEmail:
                            (await localdatabaseRepo.getUserDataFromLocalDB())!
                                .email,
                      );
                      break;
                    case PaymentType.transfer:
                      paymentRepo.chargeBank(
                        price: 0,
                        context: context,
                        userEmail:
                            (await localdatabaseRepo.getUserDataFromLocalDB())!
                                .email,
                      );
                      break;
                    case PaymentType.none:
                      // TODO: Handle this case.
                      break;
                  }
                },
              ),
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }
}

class PaymentOptionItem extends StatelessWidget {
  const PaymentOptionItem({
    Key? key,
    this.callback,
    required this.text,
    required this.subTitle,
    required this.selected,
  }) : super(key: key);

  final void Function()? callback;
  final String text;
  final String subTitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      width: size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade900),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: RadioListTile<bool>(
        value: selected,
        groupValue: true,
        onChanged: (Object? val) => callback!(),
        title: CustomTextWidget(
          text: text,
          fontSize: kfsLarge,
        ),
        subtitle: CustomTextWidget(
          text: subTitle,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
