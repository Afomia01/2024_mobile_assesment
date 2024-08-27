import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase.dart';
import '../repository/grocery_repository.dart';

class GetGroceryDetails implements UseCase<Grocery, GetGroceryDetailsParams> {
  final GroceryRepository repository;

  GetGroceryDetails(this.repository);

  @override
  Future<Either<Failure, Grocery>> call(GetGroceryDetailsParams params) async {
    return await repository.getGroceryDetails(params.id);
  }
}

class GetGroceryDetailsParams extends Equatable {
  final String id;

  const GetGroceryDetailsParams(this.id);

  @override
  List<Object?> get props => [id];
}
