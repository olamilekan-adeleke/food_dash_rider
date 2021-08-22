import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/features/food/UI/pages/home_page.dart';
import 'package:chowwe_rider/features/food/UI/widgets/header_widget.dart';
import 'package:chowwe_rider/features/food/bloc/rider_bloc.dart';
import 'package:chowwe_rider/features/food/model/cart_model.dart';
import 'package:chowwe_rider/features/food/model/order_model.dart';
import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/emums.dart';
import '../../../../cores/utils/locator.dart';

class SelectedOrderScreen extends StatelessWidget {
  SelectedOrderScreen(this.order);
  final OrderModel order;

  static final RiderRepo repo = locator<RiderRepo>();

  @override
  Widget build(BuildContext context) {
    List<String>? restaurantList = order.restaurantsList;

    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: sizerSp(20.0)),
            const HeaderWidget(iconData: null, title: 'Order    '),
            SizedBox(height: sizerSp(20.0)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: sizerSp(20),
                vertical: sizerSp(20),
              ),
              child: Column(
                children: <Widget>[
                  CustomTextWidget(
                    text: 'Thanks for accepting the order!',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/confirmed.svg',
                    height: sizerSp(100),
                    width: sizerSp(150),
                  ),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text:
                        'Please proceed to ${restaurantList!.join(', ')} to pick up the order',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    textAlign: TextAlign.center,
                  ),
                  UserDetails(order),
                  SizedBox(height: 40),
                  BlocConsumer<RiderBloc, RiderState>(
                    listener: (context, state) {
                      if (state is ChangeOrderStatusErrorState) {
                        CustomSnackBarService.showErrorSnackBar(state.message);
                      } else if (state is ChangeOrderStatusLoadedState) {
                        Get.off(OrderProcessingScreen(order));
                        CustomSnackBarService.showSuccessSnackBar('Updated!');
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeOrderStatusLoadingState) {
                        return const CustomButton.loading();
                      }

                      return CustomButton(
                        text: 'Proceed To Processing',
                        onTap: () => BlocProvider.of<RiderBloc>(context).add(
                          ChangeOrderStatusEvent(
                            order.id,
                            OrderStatusEunm.processing,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProcessingScreen extends StatelessWidget {
  OrderProcessingScreen(this.order);
  final OrderModel order;

  static final RiderRepo repo = locator<RiderRepo>();

  @override
  Widget build(BuildContext context) {
    List<String>? restaurantList = order.restaurantsList;

    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: sizerSp(20.0)),
            const HeaderWidget(iconData: null, title: 'Order    '),
            SizedBox(height: sizerSp(20.0)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: sizerSp(20),
                vertical: sizerSp(20),
              ),
              child: Column(
                children: <Widget>[
                  CustomTextWidget(
                    text: 'Proccessing',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/processing.svg',
                    height: sizerSp(100),
                    width: sizerSp(150),
                  ),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text: 'Your Order Is Processing',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    textAlign: TextAlign.center,
                  ),
                  UserDetails(order),
                  SizedBox(height: 40),
                  BlocConsumer<RiderBloc, RiderState>(
                    listener: (context, state) {
                      if (state is ChangeOrderStatusErrorState) {
                        CustomSnackBarService.showErrorSnackBar(state.message);
                      } else if (state is ChangeOrderStatusLoadedState) {
                        CustomSnackBarService.showSuccessSnackBar('Updated!');
                        Get.off(OrderEnrouteScreen(order));
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeOrderStatusLoadingState) {
                        return const CustomButton.loading();
                      }

                      return CustomButton(
                        text: 'Proceed To Enroute',
                        onTap: () => BlocProvider.of<RiderBloc>(context).add(
                          ChangeOrderStatusEvent(
                            order.id,
                            OrderStatusEunm.enroute,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderEnrouteScreen extends StatelessWidget {
  OrderEnrouteScreen(this.order);
  final OrderModel order;

  static final RiderRepo repo = locator<RiderRepo>();

  @override
  Widget build(BuildContext context) {
    List<String>? restaurantList = order.restaurantsList;

    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: sizerSp(20.0)),
            const HeaderWidget(iconData: null, title: 'Order    '),
            SizedBox(height: sizerSp(20.0)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: sizerSp(20),
                vertical: sizerSp(20),
              ),
              child: Column(
                children: <Widget>[
                  CustomTextWidget(
                    text: 'Enroute',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/enroute.svg',
                    height: sizerSp(100),
                    width: sizerSp(150),
                  ),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text:
                        'I have picked up the order ${restaurantList!.join(', ')}',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    textAlign: TextAlign.center,
                  ),
                  UserDetails(order),
                  SizedBox(height: 40),
                  BlocConsumer<RiderBloc, RiderState>(
                    listener: (context, state) {
                      if (state is ChangeOrderStatusErrorState) {
                        CustomSnackBarService.showErrorSnackBar(state.message);
                      } else if (state is ChangeOrderStatusLoadedState) {
                        CustomSnackBarService.showSuccessSnackBar('Updated!');
                        Get.off(OrderCompleteScreen(order));
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeOrderStatusLoadingState) {
                        return const CustomButton.loading();
                      }

                      return CustomButton(
                        text: 'Proceed To Completed',
                        onTap: () => BlocProvider.of<RiderBloc>(context).add(
                          ChangeOrderStatusEvent(
                            order.id,
                            OrderStatusEunm.completed,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCompleteScreen extends StatelessWidget {
  OrderCompleteScreen(this.order);
  final OrderModel order;

  static final RiderRepo repo = locator<RiderRepo>();

  @override
  Widget build(BuildContext context) {
    List<String>? restaurantList = order.restaurantsList;

    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: sizerSp(20.0)),
            const HeaderWidget(iconData: null, title: 'Order    '),
            SizedBox(height: sizerSp(20.0)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: sizerSp(20),
                vertical: sizerSp(20),
              ),
              child: Column(
                children: <Widget>[
                  CustomTextWidget(
                    text: 'Delivery succes!!!',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/confirmed.svg',
                    height: sizerSp(100),
                    width: sizerSp(150),
                  ),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text:
                        'I have  successfully delivered the order to the customer',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    textAlign: TextAlign.center,
                  ),
                  UserDetails(order),
                  SizedBox(height: 40),
                  BlocConsumer<RiderBloc, RiderState>(
                    listener: (context, state) {
                      if (state is ChangeOrderStatusErrorState) {
                        CustomSnackBarService.showErrorSnackBar(state.message);
                      } else if (state is ChangeOrderStatusLoadedState) {
                        CustomSnackBarService.showSuccessSnackBar('Updated!');
                        Get.to(OrderProcessingScreen(order));
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeOrderStatusLoadingState) {
                        return const CustomButton.loading();
                      }

                      return CustomButton(
                        text: 'Done',
                        onTap: () => Get.offAll(HomePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final List fastFoodNameList =
        order.items.map((CartModel cart) => cart.fastFoodName).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sizerSp(20)),
        CustomTextWidget(
          text: 'Customer',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: order.userDetails.fullName,
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
        ),
        SizedBox(height: sizerSp(10)),
        CustomTextWidget(
          text: 'Restaurants',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: fastFoodNameList.join(', '),
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: sizerSp(5)),
        CustomTextWidget(
          text: 'Address',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: order.userDetails.address.toString(),
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
        ),
        SizedBox(height: sizerSp(10)),
        CustomTextWidget(
          text: 'Phone number',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: order.userDetails.phoneNumber.toString(),
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
        ),
        SizedBox(height: sizerSp(10)),
        CustomTextWidget(
          text: 'Delivery Charges',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: 'N/A',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
        ),
        SizedBox(height: sizerSp(10)),
        CustomTextWidget(
          text: 'Rider Fee',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w600,
        ),
        CustomTextWidget(
          text: 'N/A',
          fontSize: sizerSp(12),
          fontWeight: FontWeight.w200,
        ),
        SizedBox(height: sizerSp(10)),
      ],
    );
  }
}
