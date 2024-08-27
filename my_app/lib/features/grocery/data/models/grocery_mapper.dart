import '../../domain/entity/grocery.dart';
import 'grocery_model.dart';

extension GroceryModelMapper on GroceryModel {
  Grocery toEntity() => Grocery(
        id: id,
        title: title,
        imageUrl: imageUrl,
        rating: rating,
        price: price,
        discount: discount,
        description: description,
        options: options,
      );
}

extension GroceryEntityMapper on Grocery {
  GroceryModel toModel() => GroceryModel(
        id: id,
        title: title,
        imageUrl: imageUrl,
        rating: rating,
        price: price,
        discount: discount,
        description: description,
        options: options,
      );
}
