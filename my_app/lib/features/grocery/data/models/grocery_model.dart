import '../../domain/entity/grocery.dart';

class GroceryModel extends Grocery {
   GroceryModel({
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
        .toList() ?? [];

    return GroceryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String,
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
      'options': options.map((option) => OptionModel.fromOption(option).toJson()).toList(),
    };
  }

  Grocery toEntity() {
    return Grocery(
      id: id,
      title: title,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      discount: discount,
      description: description,
      options: options.toList(),
    );
  }
}

class OptionModel extends Option {
   OptionModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  Option toEntity() {
    return Option(
      id: id,
      name: name,
      price: price,
    );
  }

  static OptionModel fromOption(Option option) {
    return OptionModel(
      id: option.id,
      name: option.name,
      price: option.price,
    );
  }
}
