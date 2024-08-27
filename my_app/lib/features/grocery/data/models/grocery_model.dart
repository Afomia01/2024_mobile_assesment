import '../../domain/entity/grocery.dart';
import 'option_model.dart';

class GroceryModel extends Grocery {
  const GroceryModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.rating,
    required super.price,
    required super.discount,
    required super.description,
    required super.options,
  });

  factory GroceryModel.fromJson(Map<String, dynamic> json) {
    final optionsList = (json['options'] as List<dynamic>?)
            ?.map((option) => OptionModel.fromJson(option as Map<String, dynamic>))
            .toList() ??
        [];

    return GroceryModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      description: json['description'],
      options: optionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'description': description,
      'options': options.map((option) => (option as OptionModel).toJson()).toList(),
    };
  }

  // Add the copyWith method
  GroceryModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? rating,
    double? price,
    double? discount,
    String? description,
    List<OptionModel>? options,
  }) {
    return GroceryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      description: description ?? this.description,
      options: options ?? this.options,
    );
  }
}
