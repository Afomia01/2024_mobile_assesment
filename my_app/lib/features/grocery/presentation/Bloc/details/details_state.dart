import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

abstract class DetailsPageState extends Equatable {
  const DetailsPageState();

  @override
  List<Object> get props => [];
}

class DetailsPageInitialState extends DetailsPageState {}

class DetailsPageLoadingState extends DetailsPageState {}

class DetailsPageLoadedState extends DetailsPageState {
  final Grocery grocery;

  const DetailsPageLoadedState(this.grocery);

  @override
  List<Object> get props => [grocery];
}

class DetailsPageErrorState extends DetailsPageState {
  final String message;

  const DetailsPageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
