import 'package:chowwe_rider/cores/components/custom_scaffold_widget.dart';
import 'package:chowwe_rider/cores/components/custom_text_widget.dart';
import 'package:chowwe_rider/features/food/UI/widgets/header_widget.dart';
import 'package:chowwe_rider/features/food/model/cart_model.dart';
import 'package:chowwe_rider/features/food/model/order_model.dart';
import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../../../cores/utils/sizer_utils.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen(this.id);

  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(10)),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: sizerSp(20.0)),
            const HeaderWidget(iconData: null, title: 'Order History'),
            SizedBox(height: sizerSp(10.0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: PaginateFirestore(
                itemBuilder: (
                  int index,
                  BuildContext context,
                  DocumentSnapshot<Object?> documentSnapshot,
                ) {
                  final Map<String, dynamic>? data =
                      documentSnapshot.data() as Map<String, dynamic>?;

                  final OrderModel order = OrderModel.fromMap(data!);

                  return OrderItemsWidegtII(order);
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
                    .where('order_status', isEqualTo: 'completed')
                    .where('rider_id', isEqualTo: id)
                    .orderBy('timestamp', descending: true),
                itemBuilderType: PaginateBuilderType.gridView,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: MediaQuery.of(context).size.width * 0.75,
                  mainAxisSpacing: 10,
                ),
                itemsPerPage: 10,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemsWidegtII extends StatelessWidget {
  const OrderItemsWidegtII(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final List<String> foodNameList =
        order.items.map((CartModel cart) => cart.name).toList();
    final List<String?> fastFoodNameList =
        order.items.map((CartModel cart) => cart.fastFoodName).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
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
              ),
            ),
          ),
          // SizedBox(height: sizerSp(40)),
          // CustomButton(
          //   text: OrderStatusExtension.eumnToString(
          //       order.orderStatus ?? OrderStatusEunm.pending),
          //   onTap: () {
          //     switch (order.orderStatus) {
          //       case OrderStatusEunm.pending:
          //         Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             builder: (context) => SelectedOrderScreen(order)));
          //         break;
          //       case OrderStatusEunm.accepted:
          //         Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             builder: (context) => OrderProcessingScreen(order)));
          //         break;
          //       case OrderStatusEunm.processing:
          //         Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             builder: (context) => OrderEnrouteScreen(order)));
          //         break;
          //       case OrderStatusEunm.enroute:
          //         Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             builder: (context) => OrderCompleteScreen(order)));
          //         break;
          //       case OrderStatusEunm.completed:
          //         break;
          //       case OrderStatusEunm.Null:
          //         break;

          //       default:
          //         break;
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
