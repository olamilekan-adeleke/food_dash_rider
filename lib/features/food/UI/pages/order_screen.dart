import 'package:chowwe_rider/cores/components/custom_button.dart';
import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/cores/utils/locator.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/features/auth/repo/auth_repo.dart';
import 'package:chowwe_rider/features/food/UI/pages/selected_order_screen.dart';
import 'package:chowwe_rider/features/food/UI/widgets/header_widget.dart';
import 'package:chowwe_rider/features/food/bloc/rider_bloc.dart';
import 'package:chowwe_rider/features/food/model/cart_model.dart';
import 'package:chowwe_rider/features/food/model/order_model.dart';
import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../../../cores/utils/sizer_utils.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen();

  static final AuthenticationRepo authenticationRepo =
      locator<AuthenticationRepo>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            // shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: sizerSp(20.0)),
              const HeaderWidget(iconData: null, title: 'Orders'),
              SizedBox(height: sizerSp(10.0)),
              Expanded(
                // height: MediaQuery.of(context).size.height * 0.70,
                child: PaginateFirestore(
                  itemBuilder: (
                    int index,
                    BuildContext context,
                    DocumentSnapshot<Object?> documentSnapshot,
                  ) {
                    final Map<String, dynamic>? data =
                        documentSnapshot.data() as Map<String, dynamic>?;

                    final OrderModel order = OrderModel.fromMap(data!);

                    return OrderItemsWidegt(order);
                  },
                  emptyDisplay: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: sizerSp(15)),
                        CustomTextWidget(
                          text: 'You Are Now \nAvailbale To Deliver',
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          fontSize: sizerSp(15),
                        ),
                        SizedBox(height: sizerSp(15)),
                        Icon(
                          Icons.access_time,
                          size: 200,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(height: sizerSp(15)),
                        CustomTextWidget(
                          text: 'Waiting for order...',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  query: RiderRepo.orderCollectionRef
                      .orderBy('timestamp', descending: true)
                      .where('order_status', isEqualTo: 'pending'),
                  itemBuilderType: PaginateBuilderType.gridView,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: MediaQuery.of(context).size.width * 0.85,
                    mainAxisSpacing: 10,
                  ),
                  itemsPerPage: 10,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  pageController: PageController(viewportFraction: 0.9),
                  isLive: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItemsWidegt extends StatelessWidget {
  const OrderItemsWidegt(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final List<String> foodNameList =
        order.items.map((CartModel cart) => cart.name).toList();
    final List<String?> fastFoodNameList =
        order.items.map((CartModel cart) => cart.fastFoodName).toList();

    return SizedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        // alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizerSp(5.0),
                  vertical: sizerSp(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity),
                    CustomTextWidget(
                      text: 'Delivery of ${foodNameList.join(', ')}',
                      textAlign: TextAlign.center,
                      fontSize: sizerSp(14),
                      fontWeight: FontWeight.w400,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                    SizedBox(height: sizerSp(5)),
                    CustomTextWidget(
                      text: 'Region',
                      fontSize: sizerSp(12),
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text: order.userDetails.region.toString(),
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
                      text: '${order.deliveryFee}',
                      fontSize: sizerSp(12),
                      fontWeight: FontWeight.w200,
                    ),
                    SizedBox(height: sizerSp(10)),
                    // CustomTextWidget(
                    //   text: 'Rider Fee',
                    //   fontSize: sizerSp(12),
                    //   fontWeight: FontWeight.w600,
                    // ),
                    // CustomTextWidget(
                    //   text: order.itemsFee.toString(),
                    //   fontSize: sizerSp(12),
                    //   fontWeight: FontWeight.w200,
                    // ),
                    // SizedBox(height: sizerSp(10)),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizerSp(40)),
            BlocConsumer<RiderBloc, RiderState>(
              listener: (context, state) {
                if (state is AcceptOrderStatusErrorState) {
                  CustomSnackBarService.showErrorSnackBar(state.message);
                } else if (state is AcceptOrderStatusLoadedState) {
                  print('object');
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => SelectedOrderScreen(order)));
                  // CustomNavigationService().navigateTo(
                  //   RouteName.selectedOderScreen,
                  //   argument: order,
                  // );
                }
              },
              builder: (context, state) {
                if (state is AcceptOrderStatusLoadingState &&
                    state.id == order.id) {
                  return const CustomButton.loading();
                } else if (state is DeclineOrderStatusLoadingState) {
                  return CustomButton(text: 'Accept order', onTap: () {});
                }

                return CustomButton(
                  text: 'Accept order',
                  onTap: () => BlocProvider.of<RiderBloc>(context).add(
                    AcceptOrderEvent(order),
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
            BlocConsumer<RiderBloc, RiderState>(
              listener: (context, state) {
                if (state is DeclineOrderStatusErrorState) {
                  CustomSnackBarService.showErrorSnackBar(state.message);
                }
              },
              builder: (context, state) {
                if (state is DeclineOrderStatusLoadingState &&
                    state.id == order.id) {
                  return const CustomButton.loading();
                } else if (state is AcceptOrderStatusLoadingState) {
                  return CustomButton(
                    text: 'Decline order',
                    onTap: () {},
                    color: Colors.grey,
                  );
                }

                return CustomButton(
                  text: 'Decline order',
                  onTap: () => BlocProvider.of<RiderBloc>(context).add(
                    DeclineOrderEvent(order.id),
                  ),
                  color: Colors.grey,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
