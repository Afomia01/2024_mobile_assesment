import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/features/grocery/presentation/Bloc/details/details_bloc.dart';
import 'package:my_app/features/grocery/presentation/Bloc/details/details_event.dart';
import 'package:my_app/features/grocery/presentation/Bloc/details/details_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String groceryId;

  ProductDetailsPage({required this.groceryId});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isCheeseAdded = false;
  bool _isBaconAdded = false;
  bool _isMeatAdded = false;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DetailsPageBloc>()
        ..add(FetchProductByIdEvent(widget.groceryId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<DetailsPageBloc, DetailsPageState>(
          builder: (context, state) {
            if (state is DetailsPageLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DetailsPageLoadedState) {
              final grocery = state.grocery;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            grocery.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (grocery.isDiscounted)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Discount',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            grocery.title,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '£ ${grocery.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              if (grocery.isDiscounted)
                                Text(
                                  '£ ${grocery.discountedPrice.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.red, fontSize: 18),
                                )
                              else
                                Text(
                                  '£ ${grocery.price.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.orange),
                                ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 20),
                              SizedBox(width: 4),
                              Text(
                                grocery.rating.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '4.9',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              Text(
                                'See all reviews',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            grocery.description,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'See more',
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Additional Options:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Add Cheese'),
                              Spacer(),
                              Text('+ £0.50'),
                              Checkbox(
                                value: _isCheeseAdded,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheeseAdded = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Add Bacon'),
                              Spacer(),
                              Text('+ £1.00'),
                              Checkbox(
                                value: _isBaconAdded,
                                onChanged: (value) {
                                  setState(() {
                                    _isBaconAdded = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Add Meat'),
                              Spacer(),
                              Checkbox(
                                value: _isMeatAdded,
                                onChanged: (value) {
                                  setState(() {
                                    _isMeatAdded = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          if (_quantity > 1) _quantity--;
                                        });
                                      },
                                    ),
                                    Text(
                                      '$_quantity',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Add to Basket'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DetailsPageErrorState) {
              return Center(child: Text('Error loading product details'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_app/dependency_injection.dart';
// import 'package:my_app/features/grocery/presentation/Bloc/details/details_bloc.dart';
// import 'package:my_app/features/grocery/presentation/Bloc/details/details_event.dart';
// import 'package:my_app/features/grocery/presentation/Bloc/details/details_state.dart';


// class ProductDetailsPage extends StatelessWidget {
//   final String groceryId;

//   ProductDetailsPage({required this.groceryId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<DetailsPageBloc>()
//         ..add(FetchProductByIdEvent(groceryId)),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.favorite_border, color: Colors.black),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: BlocBuilder<DetailsPageBloc, DetailsPageState>(
//           builder: (context, state) {
//             if (state is DetailsPageLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is DetailsPageLoadedState) {
//               final grocery = state.grocery;
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(
//                             grocery.imageUrl,
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         if (grocery.isDiscounted) // Show discount badge if discounted
//                           Positioned(
//                             top: 10,
//                             left: 10,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.red.withOpacity(0.7),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 'Discount',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             grocery.title,
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text(
//                                 '£ ${grocery.price.toStringAsFixed(2)}',
//                                 style: TextStyle(
//                                   decoration: TextDecoration.lineThrough,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               if (grocery.isDiscounted)
//                                 Text(
//                                   '£ ${grocery.discountedPrice.toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.red, fontSize: 18),
//                                 )
//                               else
//                                 Text(
//                                   '£ ${grocery.price.toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.orange),
//                                 ),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Icon(Icons.star, color: Colors.orange, size: 20),
//                               SizedBox(width: 4),
//                               Text(
//                                 grocery.rating.toString(),
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 '4.9',
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                               Spacer(),
//                               Text(
//                                 'See all reviews',
//                                 style: TextStyle(color: Colors.blue),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             grocery.description,
//                             style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'See more',
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             'Additional Options:',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text('Add Cheese'),
//                               Spacer(),
//                               Text('+ £0.50'),
//                               Checkbox(value: false, onChanged: (value) {}),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('Add Bacon'),
//                               Spacer(),
//                               Text('+ £1.00'),
//                               Checkbox(value: false, onChanged: (value) {}),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('Add Meat'),
//                               Spacer(),
//                               Checkbox(value: false, onChanged: (value) {}),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.remove, color: Colors.white),
//                                       onPressed: () {},
//                                     ),
//                                     Text(
//                                       '1',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.add, color: Colors.white),
//                                       onPressed: () {},
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 16),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: Text('Add to Basket'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is DetailsPageErrorState) {
//               return Center(child: Text('Error loading product details'));
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
