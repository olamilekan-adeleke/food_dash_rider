import 'dart:convert';

class PaymentModel {
  const PaymentModel({
    required this.message,
    required this.dateTime,
    required this.amount,
    required this.id,
    this.paying = true,
  });

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      message: map['message'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      amount: map['amount'] as int,
      id: map['id'] as String,
      paying: map['paying'] as bool 
    );
  }

  final String message;
  final String? id;
  final DateTime dateTime;
  final int amount;
  final bool paying;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'amount': amount,
      'id': id,
      'paying': paying,
    };
  }

  String toJson() => json.encode(toMap());
}
