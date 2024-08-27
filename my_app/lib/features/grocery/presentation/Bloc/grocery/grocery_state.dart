

import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/entity/grocery.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();
  
  @override
  List<Object> get props => [];
}

final class HomePageInitialState extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HomePageLoadedState extends HomePageState {
  final List<Grocery> groceries;

  const HomePageLoadedState(this.groceries);

  @override
  List<Object> get props => [groceries];
}

final class HomePageErrorState extends HomePageState {
  final String message;

  const HomePageErrorState(this.message);

  @override
  List<Object> get props => [message];
}
