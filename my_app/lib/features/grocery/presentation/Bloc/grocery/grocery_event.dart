

import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [Grocery];
}

class FetchAllProductsEvent extends HomePageEvent {}




// class FetchGroceryDetailsEvent extends GroceryEvent {
//   final String id;

//   const FetchGroceryDetailsEvent(this.id);

//   @override
//   List<Object> get props => [id];
// }
