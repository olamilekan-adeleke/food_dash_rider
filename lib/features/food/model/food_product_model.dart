import 'dart:convert';

class FoodProductModel {
  const FoodProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
    required this.fastFoodname,
    required this.fastFoodId,
  });

  factory FoodProductModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return FoodProductModel(
      id: documentId,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      fastFoodname: map['fast_food_name'] as String,
      price: map['price'] as int,
      fastFoodId: map['fast_food_id'] as String,
    );
  }

  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final int price;
  final String fastFoodname;
  final String fastFoodId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'price': price,
      'fast_food_name': fastFoodname,
      'fast_food_id': fastFoodId
    };
  }

  String toJson() => json.encode(toMap());
}
