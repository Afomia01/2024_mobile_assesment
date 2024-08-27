import 'package:dartz/dartz.dart';
import '../../../../core/error/excetpion.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/grocery.dart';
import '../../domain/repository/grocery_repository.dart';
import '../datasource/local/grocery_local_data_source.dart';
import '../datasource/remote/grocery_remote_data_source.dart';
import '../models/grocery_mapper.dart';

class GroceryRepositoryImpl extends GroceryRepository {
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
        final groceries = await _groceryRemoteDataSource.getGroceries();
        _groceryLocalDataSource.cacheGroceries(groceries);
        return Right(groceries.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final groceries = await _groceryLocalDataSource.getCachedGroceries();
        return Right(groceries.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Grocery>> getGroceryDetails(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final grocery = await _groceryRemoteDataSource.getGrocery(id);
        _groceryLocalDataSource.cacheGrocery(grocery);
        return Right(grocery.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final grocery = await _groceryLocalDataSource.getCachedGrocery(id);
        if (grocery != null) {
          return Right(grocery.toEntity());
        } else {
          return Left(CacheFailure('Grocery not found in cache'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
