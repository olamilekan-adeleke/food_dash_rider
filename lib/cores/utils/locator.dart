import 'package:chowwe_rider/features/auth/repo/auth_repo.dart';
// import 'package:chowwe_rider/features/food/repo/food_repo.dart';
import 'package:chowwe_rider/features/food/repo/local_database_repo.dart';
import 'package:chowwe_rider/features/food/repo/rider_repo.dart';
import 'package:chowwe_rider/features/payment/repo/payment_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepo());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<RiderRepo>(() => RiderRepo());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<LocaldatabaseRepo>(() => LocaldatabaseRepo());
  locator.registerLazySingleton<PaymentRepo>(() => PaymentRepo());
}
