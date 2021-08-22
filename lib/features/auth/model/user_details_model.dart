import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RiderDetailsModel {
  RiderDetailsModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profilePicUrl,
    this.address,
    this.region,
    this.dateJoined,
    required this.dob,
    required this.walletBalance,
  });

  factory RiderDetailsModel.fromMap(Map<String, dynamic>? map) {
    return RiderDetailsModel(
      uid: map!['uid'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      walletBalance: map['wallet_balance'] != null
          ? double.parse(map['wallet_balance'].toString())
          : 0.0,
      phoneNumber: map['phone_number'] as int,
      profilePicUrl: map['profile_pic_url'] != null
          ? map['profile_pic_url'] as String
          : null,
      dateJoined:
          map['date_joined'] != null ? map['date_joined'] as Timestamp : null,
      dob: map['dob'] != null ? map['dob'] as String : '1991-01-01',
    );
  }

  factory RiderDetailsModel.fromJson(String source) =>
      RiderDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String uid;
  final String email;
  final String fullName;
  final String dob;
  final String? address;
  final String? region;
  final int phoneNumber;
  final String? profilePicUrl;
  final Timestamp? dateJoined;
  final double? walletBalance;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
      'date_joined': dateJoined,
      'address': address,
      'region': region,
      'dob': dob,
    };
  }

  Map<String, dynamic> toMapForLocalDb() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
      'address': address,
      'region': region,
      'dob': dob,
    };
  }

  String toJson() => json.encode(toMap());

  RiderDetailsModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? dob,
    String? address,
    String? region,
    int? phoneNumber,
    String? profilePicUrl,
    Timestamp? dateJoined,
    double? walletBalance,
  }) {
    return RiderDetailsModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      dateJoined: dateJoined ?? this.dateJoined,
      walletBalance: walletBalance ?? this.walletBalance,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      region: region ?? this.region,
    );
  }
}
