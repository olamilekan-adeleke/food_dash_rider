import 'package:chowwe_rider/features/food/bloc/rider_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chowwe_rider/features/auth/bloc/auth_bloc/auth_bloc.dart';

List<BlocProvider<dynamic>> blocList(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
    BlocProvider<RiderBloc>(create: (BuildContext context) => RiderBloc()),
  ];
}
