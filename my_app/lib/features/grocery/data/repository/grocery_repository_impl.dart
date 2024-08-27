import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/excetpion.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/grocery.dart';
import '../../domain/repository/grocery_repository.dart';
import '../datasource/local/grocery_local_data_source.dart';
import '../datasource/remote/grocery_remote_data_source.dart';
import '../models/grocery_model.dart';  // Ensure you import GroceryModel

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryRemoteDataSource _groceryRemoteDataSource;
  final GroceryLocalDataSource _groceryLocalDataSource;
  final NetworkInfo _networkInfo;

  GroceryRepositoryImpl({
    required NetworkInfo networkInfo,
    required GroceryRemoteDataSource remoteDataSource,
    required GroceryLocalDataSource localDataSource,
  })  : _networkInfo = networkInfo,
        _groceryRemoteDataSource = remoteDataSource,
        _groceryLocalDataSource = localDataSource;

  @override
  Future<Either<Failure, List<Grocery>>> getAllGroceries() async {
    if (await _networkInfo.isConnected) {
      try {
        final groceryModels = await _groceryRemoteDataSource.getGroceries();
        _groceryLocalDataSource.cacheGroceries(groceryModels);
        final groceries = groceryModels.map((model) => model.toEntity()).toList();
        return Right(groceries);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final groceryModels = await _groceryLocalDataSource.getCachedGroceries();
        final groceries = groceryModels.map((model) => model.toEntity()).toList();
        return Right(groceries);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Grocery>> getGroceryDetails(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final groceryModel = await _groceryRemoteDataSource.getGrocery(id);
        _groceryLocalDataSource.cacheGrocery(groceryModel);
        return Right(groceryModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final groceryModel = await _groceryLocalDataSource.getCachedGrocery(id);
        if (groceryModel != null) {
          return Right(groceryModel.toEntity());
        } else {
          return Left(CacheFailure('Grocery not found in cache'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
