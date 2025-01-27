import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/Provider/CartProvider.dart';
import 'package:shopping_cart_app/Views/ProductListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

        create: (_) => CartProvider(),

        child: Builder(builder: (BuildContext context){


          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            home: const ProductListScreen(),

            debugShowCheckedModeBanner: false,
          );



        }),
    );

  }
}

