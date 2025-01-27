import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/Database/CartModel.dart';
import 'package:shopping_cart_app/Database/DB_HELPER.dart';
import 'package:shopping_cart_app/Models/ProductsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_app/Provider/CartProvider.dart';
import 'package:shopping_cart_app/Views/CartScreen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<ProductsModel> productsList = [];

  Future<List<ProductsModel>> getProductsApi() async {
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      productsList.clear();
      for (var i in data) {
        print("I am in");
        productsList.add(ProductsModel.fromJson(i));
      }
      return productsList;
    } else {
      print('Failed to load products');
      return productsList;
    }
  }



  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        centerTitle: true,
        //actions refers to list of widgets on the right side of App Bar title.
        actions: [
          GestureDetector(

            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen())
              );
            },

            child: Center(

              //wrapping the badge content with consumer so that count state can be accessed and displayed in app

              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.count.toString(), style: TextStyle(color: Colors.white),
                    );
                  },
                ),

                badgeColor: Colors.red,
                child: Icon(
                  Icons.shopping_cart_outlined,
                ),
                animationDuration: Duration(milliseconds: 15),
                animationType: BadgeAnimationType.slide,
                shape: BadgeShape.circle,
              ),

            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder <List<ProductsModel>>(
                future: getProductsApi(),
                builder:
                    (context, AsyncSnapshot<List<ProductsModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Waiting for data to load
                        print("Waiting for data...");
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // Error occurred while fetching data
                        print("Error: ${snapshot.error}");
                        return Center(child: Text('An error occurred: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        // Data loaded successfully
                        print("Data loaded successfully");
                    return ListView.builder(
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          return Card(

                            elevation: 2,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        image: NetworkImage(snapshot
                                            .data![index].image
                                            .toString()),
                                        height: 80,
                                        width: 80,
                                        // fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded( //because title is long
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 3,),
                                            Text(snapshot.data![index].title
                                                .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 10,),

                                            Text("Price: " + r"$" +
                                                snapshot.data![index].price
                                                    .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),),

                                            SizedBox(height: 5,),

                                            Text("Rating: " +
                                                snapshot.data![index].rating!
                                                    .rate
                                                    .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400
                                              ),),

                                            Align(

                                              alignment: Alignment.centerRight,

                                              child: GestureDetector(

                                                onTap: () {
                                                  dbHelper!.insert(
                                                      Cart(
                                                          indexId: index,
                                                          productId: index.toString(),
                                                          title: snapshot.data![index].title.toString(),
                                                          initialPrice: double.parse(snapshot.data![index].price.toString()),
                                                          productPrice: double.parse(snapshot.data![index].price.toString()),
                                                          quantity: 1,
                                                          rating: double.parse(snapshot.data![index].rating!.rate.toString()),
                                                          image: snapshot.data![index].image!.toString()
                                                      )
                                                  ).then((value) {
                                                    print("Data stored successfully in DB");

                                                    cartProvider.incrementCount();
                                                    cartProvider.incrementTotalPrice(double.parse(snapshot.data![index].price.toString()));
                                                    cartProvider.refreshValues();

                                                  }).onError((error, stackTrace) {
                                                    print("DB ERROR... "+error.toString());
                                                  });



                                                },

                                                child: Container(

                                                  height: 40,
                                                  width: 120,

                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius
                                                          .circular(10)
                                                  ),
                                                  child: Center(
                                                      child: Text("Add to Cart",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 15
                                                        ),
                                                      )
                                                  ),
                                                ),
                                              ),

                                            ),

                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                        // No data available
                        print("No data available");
                        return Center(child: Text('No products available'));
                  }
                }),
          )
        ],
      ),
    );
  }
}
