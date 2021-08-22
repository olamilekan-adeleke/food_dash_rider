import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:stacked_services/stacked_services.dart';
import 'cores/utils/bloc_list.dart';
import 'cores/utils/route_name.dart';
import 'cores/utils/router.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocList(context),
      child: Sizer(
        builder: (
          BuildContext context,
          Orientation orientation,
          DeviceType deviceType,
        ) =>
            MaterialApp(
          title: 'Food Dash',
          theme: ThemeData(primaryColor: const Color(0xffFF9A02)),
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: RouteName.inital,
        ),
      ),
    );
  }
}
