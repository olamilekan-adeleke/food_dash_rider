import 'package:sizer/sizer.dart';

/// return a percentage of thr screen height in respest to the  value given
double sizerHeight(double value) => value.h;

/// return a percentage of thr screen width in respest to the  value given
double sizerWidth(double value) => value.w;


/// Calculates the sp (Scalable Pixel) depending on the device's screen size
double sizerSp(double value) => value.sp;
