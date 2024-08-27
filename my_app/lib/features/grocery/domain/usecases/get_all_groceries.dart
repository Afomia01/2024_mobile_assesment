import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/grocery.dart';
import '../repository/grocery_repository.dart';

class GetAllGroceries {
  final GroceryRepository repository;

  GetAllGroceries(this.repository);

  Future<Either<Failure, List<Grocery>>> call() async {
    return await repository.getAllGroceries();
  }
}
