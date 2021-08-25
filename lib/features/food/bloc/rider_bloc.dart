import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chowwe_rider/cores/utils/extenions.dart';
import 'package:chowwe_rider/cores/utils/locator.dart';
import 'package:chowwe_rider/cores/utils/navigator_service.dart';
import 'package:chowwe_rider/cores/utils/route_name.dart';
import 'package:chowwe_rider/features/food/model/order_model.dart';
import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../cores/utils/emums.dart';

part 'rider_event.dart';
part 'rider_state.dart';

class RiderBloc extends Bloc<RiderEvent, RiderState> {
  RiderBloc() : super(RiderInitial());

  static final RiderRepo riderRepo = locator<RiderRepo>();

  @override
  Stream<RiderState> mapEventToState(
    RiderEvent event,
  ) async* {
    if (event is ChangeOrderStatusEvent) {
      try {
        yield ChangeOrderStatusLoadingState();
        await riderRepo.chagneOrderStatus(
          event.id,
          OrderStatusExtension.eumnToString(event.orderStatus),
          completed: event.orderStatus == OrderStatusEunm.completed,
        );
        yield ChangeOrderStatusLoadedState();
      } on Exception catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield ChangeOrderStatusErrorState(e.toString());
      }
    } else if (event is AcceptOrderEvent) {
      try {
        yield AcceptOrderStatusLoadingState(event.order.id);
        await riderRepo.acceptOrderStatus(event.order.id);
        CustomNavigationService().navigateTo(
          RouteName.selectedOderScreen,
          argument: event.order,
        );
        yield AcceptOrderStatusLoadedState();
      } on Exception catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield AcceptOrderStatusErrorState(e.toString());
      }
    } else if (event is DeclineOrderEvent) {
      try {
        yield DeclineOrderStatusLoadingState(event.orderId);
        await riderRepo.declineOrderStatus(event.orderId);
        yield DeclineOrderStatusLoadedState();
      } on Exception catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield DeclineOrderStatusErrorState(e.toString());
      }
    }
  }
}
