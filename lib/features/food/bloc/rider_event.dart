part of 'rider_bloc.dart';

abstract class RiderEvent extends Equatable {
  const RiderEvent();

  @override
  List<Object> get props => [];
}

class AcceptOrderEvent extends RiderEvent {
  const AcceptOrderEvent(this.order);

  final OrderModel order;
}

class DeclineOrderEvent extends RiderEvent {
  const DeclineOrderEvent(this.orderId);

  final String orderId;
}

class ChangeOrderStatusEvent extends RiderEvent {
  final String id;
  final OrderStatusEunm orderStatus;

  const ChangeOrderStatusEvent(this.id, this.orderStatus);
}
