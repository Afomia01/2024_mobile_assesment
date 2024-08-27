import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

import '../repository/grocery_repository.dart';

class GetGroceryDetails {
  final GroceryRepository repository;

  GetGroceryDetails(this.repository);

  Future<Either<Failure, Grocery>> call(String id) async {
    return await repository.getGroceryDetails(id);
  }
}

// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:my_app/features/grocery/domain/entity/grocery.dart';

// import '../../../../core/error/failure.dart';
// import '../repository/grocery_repository.dart';

// class GetGroceryDetails {
//   final GroceryRepository repository;

//   GetGroceryDetails(this.repository);

//   Future<Either<Failure, Grocery>> call(String id) async {
//     return await repository.getGroceryDetails(id);
//   }
// }

// class GetGroceryDetailsParams extends Equatable {
//   final String id;

//   const GetGroceryDetailsParams(this.id);

//   @override
//   List<Object?> get props => [id];
// }
