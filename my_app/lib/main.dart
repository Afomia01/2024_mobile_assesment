import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dependency_injection.dart'; // Updated to match the DI setup file
import 'features/grocery/presentation/Bloc/grocery/grocery_bloc.dart';
import 'features/grocery/presentation/pages/grocery_home.dart';
import 'features/grocery/presentation/pages/splash_screen.dart';
import 'features/grocery/domain/usecases/get_all_groceries.dart';
import 'features/grocery/domain/usecases/get_grocery_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  setupLocator(); // Updated to match the method name in the DI setup
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GroceryBloc>(), // Updated to use getIt for DI
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme( // Example of custom font using Google Fonts
            Theme.of(context).textTheme,
          ),
        ),
        home: SplashScreen(),
        routes: {
          '/grocery': (context) => GroceryPage(), // Define other routes as needed
        },
      ),
    );
  }
}
