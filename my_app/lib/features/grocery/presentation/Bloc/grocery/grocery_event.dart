
import 'package:equatable/equatable.dart';

abstract class GroceryEvent extends Equatable {
  const GroceryEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllGroceries extends GroceryEvent {}

class FetchGroceryDetails extends GroceryEvent {
  final String id;

  const FetchGroceryDetails(this.id);

  @override
  List<Object?> get props => [id];
}
