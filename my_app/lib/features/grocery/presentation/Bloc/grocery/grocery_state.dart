// lib/features/grocery/presentation/bloc/grocery_state.dart

import 'package:equatable/equatable.dart';
import '../../../domain/entity/grocery.dart';


abstract class GroceryState extends Equatable {
  const GroceryState();

  @override
  List<Object?> get props => [];
}

class GroceryInitial extends GroceryState {}

class GroceryLoading extends GroceryState {}

class GroceryLoaded extends GroceryState {
  final List<Grocery> groceries;

  const GroceryLoaded(this.groceries);

  @override
  List<Object?> get props => [groceries];
}

class GroceryDetailLoaded extends GroceryState {
  final Grocery grocery;

  const GroceryDetailLoaded(this.grocery);

  @override
  List<Object?> get props => [grocery];
}

class GroceryFailure extends GroceryState {
  final String message;

  const GroceryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
