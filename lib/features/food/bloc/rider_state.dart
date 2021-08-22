part of 'rider_bloc.dart';

abstract class RiderState extends Equatable {
  const RiderState();

  @override
  List<Object> get props => [];
}

class RiderInitial extends RiderState {}

class AcceptOrderStatusInitialState extends RiderState {}

class AcceptOrderStatusLoadingState extends RiderState {
  final String id;

  AcceptOrderStatusLoadingState(this.id);
}

class AcceptOrderStatusLoadedState extends RiderState {}

class AcceptOrderStatusErrorState extends RiderState {
  const AcceptOrderStatusErrorState(this.message);

  final String message;
}

class DeclineOrderStatusInitialState extends RiderState {}

class DeclineOrderStatusLoadingState extends RiderState {
  final String id;

  DeclineOrderStatusLoadingState(this.id);
}

class DeclineOrderStatusLoadedState extends RiderState {}

class DeclineOrderStatusErrorState extends RiderState {
  const DeclineOrderStatusErrorState(this.message);

  final String message;
}

class ChangeOrderStatusInitialState extends RiderState {}

class ChangeOrderStatusLoadingState extends RiderState {}

class ChangeOrderStatusLoadedState extends RiderState {}

class ChangeOrderStatusErrorState extends RiderState {
  const ChangeOrderStatusErrorState(this.message);

  final String message;
}
