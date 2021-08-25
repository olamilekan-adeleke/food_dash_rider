import 'package:chowwe_rider/cores/utils/extenions.dart';
import 'package:chowwe_rider/cores/utils/snack_bar_service.dart';
import 'package:chowwe_rider/features/auth/model/user_details_model.dart';
import 'package:chowwe_rider/features/auth/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../cores/utils/emums.dart';
import 'package:get_it/get_it.dart';

import 'local_database_repo.dart';

class RiderRepo {
  static AuthenticationRepo authenticationRepo =
      GetIt.instance<AuthenticationRepo>();

  static final LocaldatabaseRepo localdatabaseRepo =
      GetIt.instance<LocaldatabaseRepo>();
  final CollectionReference<Map<String, dynamic>> riderCollectionRef =
      FirebaseFirestore.instance.collection('rider');

  static final CollectionReference<Map<String, dynamic>> orderCollectionRef =
      FirebaseFirestore.instance.collection('orders');

  Stream<DocumentSnapshot<Map<String, dynamic>>> userWalletStream() async* {
    final String? userUid = authenticationRepo.getUserUid();

    yield* riderCollectionRef.doc(userUid).snapshots();
  }

  Future<void> acceptOrderStatus(String id) async {
    try {
      final RiderDetailsModel? riderDetails =
          await localdatabaseRepo.getUserDataFromLocalDB();
      await orderCollectionRef.doc(id).update(
        {
          'order_status':
              OrderStatusExtension.eumnToString(OrderStatusEunm.accepted),
          'rider_details': riderDetails!.toMap(),
          'rider_id': riderDetails.uid,
        },
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> declineOrderStatus(String id) async {
    try {
      final RiderDetailsModel? riderDetails =
          await localdatabaseRepo.getUserDataFromLocalDB();
      await orderCollectionRef.doc(id).update(
        {
          'decline_list': FieldValue.arrayUnion([riderDetails?.uid]),
        },
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> chagneOrderStatus(String id, String status,
      {bool completed = false}) async {
    try {
      await orderCollectionRef.doc(id).update({
        'order_status': status,
        if (completed == true) 'pay_status': 'pending',
      });

      if (completed) {
        CustomSnackBarService.showSuccessSnackBar(
            'Confrimation Message Sent To User!');
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderSteam(String id) async* {
    yield* orderCollectionRef.doc(id).snapshots();
  }
}
