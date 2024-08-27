import 'package:dartz/dartz.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';
import 'package:my_app/features/grocery/domain/repository/grocery_repository.dart';

import '../../../../core/error/failure.dart';

class GetGroceryDetails {
  final GroceryRepository repository; // Assume this is your data repository

  GetGroceryDetails(this.repository);

  Future<Either<Failure, Grocery>> call(Params params) async {
    return await repository.getGroceryDetails(params.id);
  }
}

class Params {
  final String id;

  Params({required this.id});
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
