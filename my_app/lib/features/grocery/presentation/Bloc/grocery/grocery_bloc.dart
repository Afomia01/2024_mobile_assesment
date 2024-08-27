import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/grocery/domain/usecases/get_all_groceries.dart';
import 'package:my_app/features/grocery/presentation/Bloc/grocery/grocery_event.dart';
import 'package:my_app/features/grocery/presentation/Bloc/grocery/grocery_state.dart';



class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllGroceries getAllGroceries;

  HomePageBloc({required this.getAllGroceries}) : super(HomePageInitialState()) {
    on<FetchAllProductsEvent>(_onFetchAllProducts);
  
  }

  Future<void> _onFetchAllProducts(FetchAllProductsEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());

    final result = await getAllGroceries();
    result.fold(
      (failure) => emit(const HomePageErrorState('Failed to fetch products')),
      (products) => emit(HomePageLoadedState(products)),
    );
  }

  

  
}

