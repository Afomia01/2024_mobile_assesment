import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

abstract class GroceryRepository {
  Future<Either<Failure, List<Grocery>>> getAllGroceries();
  Future<Either<Failure, Grocery>> getGroceryDetails(String id);

}
