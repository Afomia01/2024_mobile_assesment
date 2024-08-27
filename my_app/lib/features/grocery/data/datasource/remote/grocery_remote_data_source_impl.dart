import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/error/excetpion.dart';
import '../../models/grocery_model.dart';
import 'grocery_remote_data_source.dart';

class GroceryRemoteDataSourceImpl extends GroceryRemoteDataSource {
  final http.Client client;
  final String _baseUrl;

  GroceryRemoteDataSourceImpl({
    required this.client,
  }) : _baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries'; 

  @override
  Future<List<GroceryModel>> getGroceries() async {
    try {
      final response = await client.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> groceries = jsonDecode(response.body)['data'];
        return groceries.map((e) => GroceryModel.fromJson(e)).toList();
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<GroceryModel> getGrocery(String id) async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        return GroceryModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
