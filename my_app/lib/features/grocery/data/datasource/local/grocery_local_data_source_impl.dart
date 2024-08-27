import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/excetpion.dart';
import '../../models/grocery_model.dart';
import 'grocery_local_data_source.dart';

class GroceryLocalDataSourceImpl extends GroceryLocalDataSource {
  final SharedPreferences sharedPreferences;

  GroceryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<GroceryModel>> getCachedGroceries() async {
    final jsonString = sharedPreferences.getString('cached_groceries');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => GroceryModel.fromJson(e)).toList();
    } else {
      throw CacheException(message: 'No cached groceries found');
    }
  }

  @override
  Future<GroceryModel?> getCachedGrocery(String id) async {
    final jsonString = sharedPreferences.getString('cached_groceries');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final groceryJson = jsonList.firstWhere(
        (e) => GroceryModel.fromJson(e).id == id,
        orElse: () => null,
      );
      return groceryJson != null ? GroceryModel.fromJson(groceryJson) : null;
    } else {
      return null;
    }
  }

  @override
  Future<void> cacheGroceries(List<GroceryModel> groceries) async {
    final jsonList = groceries.map((e) => e.toJson()).toList();
    await sharedPreferences.setString('cached_groceries', jsonEncode(jsonList));
  }

  @override
  Future<void> cacheGrocery(GroceryModel grocery) async {
    final jsonString = sharedPreferences.getString('cached_groceries');
    List<dynamic> jsonList = [];
    if (jsonString != null) {
      jsonList = jsonDecode(jsonString);
    }
    jsonList.add(grocery.toJson());
    await sharedPreferences.setString('cached_groceries', jsonEncode(jsonList));
  }

//   @override
//   Future<void> cacheCartItem(GroceryModel grocery) async {
//     final jsonString = sharedPreferences.getString('cached_cart_items');
//     List<dynamic> jsonList = [];
//     if (jsonString != null) {
//       jsonList = jsonDecode(jsonString);
//     }
//     jsonList.add(grocery.toJson());
//     await sharedPreferences.setString('cached_cart_items', jsonEncode(jsonList));
//   }

//   @override
//   Future<List<GroceryModel>> getCachedCartItems() async {
//     final jsonString = sharedPreferences.getString('cached_cart_items');
//     if (jsonString != null) {
//       final List<dynamic> jsonList = jsonDecode(jsonString);
//       return jsonList.map((e) => GroceryModel.fromJson(e)).toList();
//     } else {
//       return [];
//     }
//   }

//   @override
//   Future<void> updateCartItemQuantity(String id, int quantity) async {
//     final jsonString = sharedPreferences.getString('cached_cart_items');
//     if (jsonString != null) {
//       final List<dynamic> jsonList = jsonDecode(jsonString);
//       final updatedList = jsonList.map((e) {
//         final grocery = GroceryModel.fromJson(e);
//         if (grocery.id == id) {
//           return grocery.copyWith(quantity: quantity).toJson();
//         }
//         return e;
//       }).toList();
//       await sharedPreferences.setString('cached_cart_items', jsonEncode(updatedList));
//     }
//   }
}
