import '../../models/grocery_model.dart';

abstract class GroceryRemoteDataSource {
  Future<List<GroceryModel>> getGroceries();
  Future<GroceryModel> getGrocery(String id);
}
