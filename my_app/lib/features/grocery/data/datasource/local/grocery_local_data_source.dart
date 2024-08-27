import '../../models/grocery_model.dart';

abstract class GroceryLocalDataSource {
  Future<List<GroceryModel>> getCachedGroceries();
  Future<GroceryModel?> getCachedGrocery(String id);
  Future<void> cacheGroceries(List<GroceryModel> groceries);
  Future<void> cacheGrocery(GroceryModel grocery);
  // Future<void> cacheCartItem(GroceryModel grocery);
  // Future<List<GroceryModel>> getCachedCartItems();
  // Future<void> updateCartItemQuantity(String id, int quantity);
}
