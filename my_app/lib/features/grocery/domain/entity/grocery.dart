//check if it requires equitable and we have to compare anything later.
import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/entity/option.dart';

class Grocery extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final double price;
  final double discount;
  final String description;
  final List<Option> options;

  const Grocery({
    required this.id, 
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
    required this.options,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, rating, price, discount, description, options];

double get discountedPrice {
    return price - (price * discount / 100);
  }

  // Method to check if a discount is available
  bool get isDiscounted {
    return discount > 0;
  }
}

