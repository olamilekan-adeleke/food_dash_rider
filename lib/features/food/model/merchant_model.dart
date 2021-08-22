import 'dart:convert';

class MerchantModel {
  const MerchantModel({
    required this.id,
    required this.name,
    required this.image,
    required this.categories,
    required this.rating,
    required this.numberOfRating,
  });

  factory MerchantModel.fromMap(Map<String, dynamic> map, String documentId) {
    return MerchantModel(
      id: documentId,
      name: map['name'] as String,
      image: map['image'] as String,
      categories: List<String>.from(map['categories'] as List<dynamic>),
      // rating: map['rating'] as double,
      rating: double.parse(map['rating'].toString()[0]),
      numberOfRating: map['number_of_ratings'] as int,
    );
  }

  final String id;
  final String name;
  final String image;
  final List<String> categories;
  final double rating;
  final int numberOfRating;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'categories': categories,
      'rating': rating,
      'number_of_ratings': numberOfRating,
    };
  }

  String toJson() => json.encode(toMap());
}
