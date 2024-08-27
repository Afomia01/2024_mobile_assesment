import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/grocery/presentation/pages/grocery_details.dart';
import '../../domain/entity/grocery.dart';
import '../Bloc/grocery/grocery_bloc.dart';
import '../Bloc/grocery/grocery_state.dart';

class GroceryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensure this widget is within the BlocProvider context
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the title content
          children: [
            Icon(Icons.fastfood, color: Colors.orange),
            SizedBox(width: 8),
            Text(
              "Burger",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.filter_list), // Keep filter icon on the search bar
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state is HomePageLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomePageLoadedState) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: state.groceries.length,
                      itemBuilder: (context, index) {
                        final grocery = state.groceries[index];
                        return GroceryCard(grocery: grocery);
                      },
                    );
                  } else if (state is HomePageErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text("No groceries available."));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroceryCard extends StatefulWidget {
  final Grocery grocery;

  const GroceryCard({Key? key, required this.grocery}) : super(key: key);

  @override
  _GroceryCardState createState() => _GroceryCardState();
}

class _GroceryCardState extends State<GroceryCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final grocery = widget.grocery;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              groceryId: grocery.id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center text and icons
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(grocery.imageUrl, fit: BoxFit.cover, height: 80, width: double.infinity),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center text and icons
                children: [
                  Text(grocery.title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text(grocery.rating.toString(), style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 4),
                  if (grocery.isDiscounted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                      children: [
                        Text(
                          '£${grocery.price.toStringAsFixed(2)}',
                          style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '£${grocery.discountedPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )
                  else
                    Text('£${grocery.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
