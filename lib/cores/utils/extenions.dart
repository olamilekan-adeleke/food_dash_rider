import 'package:chowwe_rider/cores/utils/emums.dart';

/// extension for the order eumn
class OrderStatusExtension {
  static String eumnToString(OrderStatusEunm orderStatusEunm) {
    switch (orderStatusEunm) {
      case OrderStatusEunm.pending:
        return 'pending';
      case OrderStatusEunm.accepted:
        return 'accepted';
      case OrderStatusEunm.processing:
        return 'processing';
      case OrderStatusEunm.enroute:
        return 'enroute';
      case OrderStatusEunm.completed:
        return 'completed';

      case OrderStatusEunm.Null:
        return 'null';
    }
  }

  static OrderStatusEunm stringToEunm(String string) {
    switch (string) {
      case 'pending':
        return OrderStatusEunm.pending;
      case 'accepted':
        return OrderStatusEunm.accepted;
      case 'processing':
        return OrderStatusEunm.processing;
      case 'enroute':
        return OrderStatusEunm.enroute;
      case 'completed':
        return OrderStatusEunm.completed;
      default:
        return OrderStatusEunm.Null;

      // return OrderStatusEunm.pending;
    }
  }

  // static int eumnToInt(OrderStatusEunm? orderStatusEunm) {
  //   switch (orderStatusEunm) {
  //     case OrderStatusEunm.pending:
  //       return 0;
  //     case OrderStatusEunm.accepted:
  //       return 1;
  //     case OrderStatusEunm.processing:
  //       return 2;
  //     case OrderStatusEunm.enroute:
  //       return 3;
  //     case OrderStatusEunm.completed:
  //       return 4;
  //     case OrderStatusEunm.Null:
  //       return 0;

  //       defau
  //   }
  // }
}
