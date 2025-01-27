import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/Database/DB_HELPER.dart';
import 'package:shopping_cart_app/Provider/CartProvider.dart';

import '../Database/CartModel.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Products"),
        centerTitle: true,
        //actions refers to list of widgets on the right side of App Bar title.
        actions: [
          Center(

            //wrapping the badge content with consumer so that count state can be accessed and displayed in app

            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.count.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),

              badgeColor: Colors.red,
              child: Icon(
                Icons.shopping_basket_outlined,
              ),
              animationDuration: Duration(milliseconds: 15),
              animationType: BadgeAnimationType.slide,
              shape: BadgeShape.circle,
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
              child: FutureBuilder(

                  future: cartProvider.getCartData(),

                  builder: (context, AsyncSnapshot<List<Cart>> snapshot) {

                    if (!snapshot.hasData) {
                    return Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.black,),
                    );

                    }

                    else if (snapshot.data!.isEmpty){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Image(
                                image: AssetImage("images/empty_cart.png"),
                            ),
                            SizedBox(height: 10,),
                            Text("Please Add Some Items First !",
                            style: Theme.of(context).textTheme.headline6,),
                            SizedBox(height: 50,),

                          ],

                        ),
                      );
                    }

                    else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(

                              // elevation: 2,

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      dbHelper!.deleteItem(
                                                          snapshot.data![index].indexId!
                                                      );

                                                      cartProvider.decrementCount();
                                                      cartProvider.decrementTotalPrice(
                                                          double.parse(
                                                              snapshot.data![index].productPrice.toString()
                                                          )
                                                      );
                                                    },
                                                    child: Icon(Icons.delete),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10,),

                                              Text("Price: " + r"$" +
                                                  snapshot.data![index]
                                                      .productPrice!.toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600
                                                ),),

                                              SizedBox(height: 5,),

                                              Text("Rating: " +
                                                  snapshot.data![index].rating
                                                      .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400
                                                ),),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [


                                                  GestureDetector(

                                                    onTap: (){

                                                      int quantity = snapshot.data![index].quantity!;
                                                      double initialPrice = snapshot.data![index].initialPrice!;

                                                      if(quantity > 1){
                                                        quantity--;

                                                        double calculatedPrice = initialPrice * quantity;

                                                        dbHelper!.updateQuantity(
                                                            Cart(
                                                                indexId: snapshot.data![index].indexId,
                                                                productId: snapshot.data![index].productId.toString(),
                                                                title: snapshot.data![index].title.toString(),
                                                                initialPrice: initialPrice,
                                                                productPrice: calculatedPrice,
                                                                quantity: quantity,
                                                                rating: snapshot.data![index].rating,
                                                                image: snapshot.data![index].image.toString()
                                                            )
                                                        ).then( (value) {
                                                          cartProvider.decrementTotalPrice(initialPrice);
                                                          // quantity = 0;
                                                          // calculatedPrice = 0;
                                                        }).onError((error, stackTrace) {
                                                          print("ERROR WHILE ADD: "+error.toString());
                                                        });

                                                      }




                                                    },

                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.indigo,
                                                            borderRadius: BorderRadius.circular(6)

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Icon(Icons.remove,
                                                            color: Colors.white,
                                                            size: 20,),
                                                        )
                                                    ),
                                                  ),



                                                  SizedBox(width: 4,),

                                                  Text(
                                                    snapshot.data![index].quantity.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      // decoration: TextDecoration.underline
                                                    ),
                                                  ),

                                                  SizedBox(width: 4,),



                                                  GestureDetector(
                                                    onTap: (){
                                                      int quantity = snapshot.data![index].quantity!;
                                                      double initialPrice = snapshot.data![index].initialPrice!;

                                                      quantity++;

                                                      double calculatedPrice = initialPrice * quantity;

                                                      dbHelper!.updateQuantity(
                                                          Cart(
                                                              indexId: snapshot.data![index].indexId,
                                                              productId: snapshot.data![index].productId.toString(),
                                                              title: snapshot.data![index].title.toString(),
                                                              initialPrice: initialPrice,
                                                              productPrice: calculatedPrice,
                                                              quantity: quantity,
                                                              rating: snapshot.data![index].rating,
                                                              image: snapshot.data![index].image.toString()
                                                          )

                                                      ).then( (value) {
                                                        // quantity = 0;
                                                        // calculatedPrice = 0;
                                                        cartProvider.incrementTotalPrice(initialPrice);
                                                      }).onError((error, stackTrace) {
                                                        print("ERROR WHILE ADD: "+error.toString());
                                                      });



                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.indigo,
                                                            borderRadius: BorderRadius.circular(6)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Icon(Icons.add,
                                                            color: Colors.white,
                                                            size: 20,),
                                                        )
                                                    ),
                                                  ),
                                                ],
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
                    }
                  }
              )
          ),


          Consumer<CartProvider>(
            
            builder: (BuildContext context, value, child) {
              return Visibility(
                visible: value.totalPrice.toStringAsFixed(2) == "0.00" ? false : true,
                  
                  child: Column(
                    children: [
                      ReuseableRowDisplay(title: "Sub Total", value: value.totalPrice.toStringAsFixed(2)),
                      
                      ReuseableRowDisplay(title: "Discount", value: "- "+(value.totalPrice * 0.05).toStringAsFixed(2)+" (5%)"),
                      ReuseableRowDisplay(title: "Total", value:(value.totalPrice - (value.totalPrice * 0.05)).toStringAsFixed(2))
                    ],
                  )
              );
            },
          ),

        ],
      ),

    );
  }
}

class ReuseableRowDisplay extends StatelessWidget {

  String title , value;

  ReuseableRowDisplay({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ),),
            Text(r"$ " + value, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              color: Colors.white
            ),),
          ],
        ),
      ),
    );
  }
}

