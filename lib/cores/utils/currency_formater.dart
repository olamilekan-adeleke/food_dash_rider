import 'package:intl/intl.dart';

String currencyFormatter(int amount) {
  final NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
  return formatter.format(amount);
}
