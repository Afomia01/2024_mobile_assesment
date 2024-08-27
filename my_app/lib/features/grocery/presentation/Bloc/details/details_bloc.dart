import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/features/grocery/domain/usecases/get_grocery_details.dart';
import 'package:my_app/features/grocery/presentation/Bloc/details/details_event.dart';
import 'package:my_app/features/grocery/presentation/Bloc/details/details_state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  final GetGroceryDetails getGroceryDetails;

  DetailsPageBloc({required this.getGroceryDetails}) : super(DetailsPageInitialState()) {
    on<FetchProductByIdEvent>(_onFetchProductByIdEvent);
  }

  Future<void> _onFetchProductByIdEvent(FetchProductByIdEvent event, Emitter<DetailsPageState> emit) async {
    emit(DetailsPageLoadingState());

    final failureOrGrocery = await getGroceryDetails(Params(id: event.id));
    
    failureOrGrocery.fold(
      (failure) => emit(DetailsPageErrorState(message: _mapFailureToMessage(failure))),
      (grocery) => emit(DetailsPageLoadedState( grocery)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map failure to user-friendly message
    // Implement your mapping logic here
    return 'An unexpected error occurred';
  }
}
