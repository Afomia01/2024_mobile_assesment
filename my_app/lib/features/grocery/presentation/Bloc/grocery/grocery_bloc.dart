import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:my_app/core/usecase.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entity/grocery.dart';
import '../../../domain/usecases/get_all_groceries.dart';
import '../../../domain/usecases/get_grocery_details.dart';

import 'grocery_event.dart';
import 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  final GetAllGroceries getAllGroceries;
  final GetGroceryDetails getGroceryDetails;

  GroceryBloc({
    required this.getAllGroceries,
    required this.getGroceryDetails,
  }) : super(GroceryInitial()) {
    on<FetchAllGroceries>(_onFetchAllGroceries);
    on<FetchGroceryDetails>(_onFetchGroceryDetails);
  }

  Future<void> _onFetchAllGroceries(
      FetchAllGroceries event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    final Either<Failure, List<Grocery>> failureOrGroceries = await getAllGroceries();

    failureOrGroceries.fold(
      (failure) => emit(GroceryFailure(_mapFailureToMessage(failure))),
      (groceries) => emit(GroceryLoaded(groceries)),
    );
  }

  Future<void> _onFetchGroceryDetails(
      FetchGroceryDetails event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    final failureOrGrocery = await getGroceryDetails(GetGroceryDetailsParams(event.id));

    failureOrGrocery.fold(
      (failure) => emit(GroceryFailure(_mapFailureToMessage(failure))),
      (grocery) => emit(GroceryDetailLoaded(grocery)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure is ServerFailure ? failure.message : 'Unexpected error occurred';
  }
}
