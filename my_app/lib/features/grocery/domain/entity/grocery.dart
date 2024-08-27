import 'package:equatable/equatable.dart';

// lib/features/grocery/domain/entity/grocery.dart

class Grocery extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final double price;
  final double discount;
  final String description;
  final List<Option> options;

  Grocery({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
    required this.options,
  });

  double get discountedPrice {
    return price - (price * discount / 100);
  }

  // Method to check if a discount is available
  bool get isDiscounted {
    return discount > 0;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        rating,
        price,
        discount,
        description,
        options,
      ];
}

class Option extends Equatable {
  final String id;
  final String name;
  final double price;

  Option({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, price];
}
