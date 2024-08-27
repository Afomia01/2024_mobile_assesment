import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/grocery/data/datasource/local/grocery_local_data_source.dart';
import 'features/grocery/data/datasource/local/grocery_local_data_source_impl.dart';
import 'features/grocery/data/datasource/remote/grocery_remote_data_source.dart';
import 'features/grocery/data/datasource/remote/grocery_remote_data_source_impl.dart';
import 'features/grocery/data/repository/grocery_repository_impl.dart';
import 'features/grocery/domain/repository/grocery_repository.dart';
import 'features/grocery/domain/usecases/get_all_groceries.dart';
import 'features/grocery/domain/usecases/get_grocery_details.dart';
import 'features/grocery/presentation/Bloc/grocery/grocery_bloc.dart';
import 'core/network/network_info.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  final client = http.Client();
  final internetConnectionChecker = InternetConnectionChecker();

  // Registering external dependencies
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<http.Client>(client);
  getIt.registerSingleton<InternetConnectionChecker>(internetConnectionChecker);

  // Core dependencies
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // Data sources
  getIt.registerLazySingleton<GroceryRemoteDataSource>(
    () => GroceryRemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<GroceryLocalDataSource>(
    () => GroceryLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerSingleton<GroceryRepository>(
    GroceryRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerFactory(() => GetAllGroceries(getIt()));
  getIt.registerFactory(() => GetGroceryDetails(getIt()));

  // Bloc
  getIt.registerFactory(
    () => GroceryBloc(
      getAllGroceries: getIt<GetAllGroceries>(),
      getGroceryDetails: getIt<GetGroceryDetails>(),
    ),
  );
}
