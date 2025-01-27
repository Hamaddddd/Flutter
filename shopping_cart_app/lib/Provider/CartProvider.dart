

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database/CartModel.dart';
import '../Database/DB_HELPER.dart';


// Provider class is used to provide the variables along with their inc/dec methods to the widget which wants to consume.
// in short provider is used to manage state inside app and provide it to any consumer widget where needed instead of passing as props.



class CartProvider with ChangeNotifier{

  int _count = 0;
  double _totalPrice = 0.0;

  DBHelper? dbHelper = DBHelper();

  late Future<List<Cart>> _cartList;

  Future<List<Cart>> get cartList => _cartList;


  //Constructor for setting values in shared prefs in start when object of provider is created.
  //Also calling the getValues func so that the last time stored value of count appears on badge
  CartProvider(){
    setValues_in_sharedPrefs();
    getValues_from_sharedPrefs();
  }

  int get count => _count;
  double get totalPrice => _totalPrice;

  Future<void> setValues_in_sharedPrefs() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setInt("count_value", _count);
    sp.setDouble("totalPrice_value", _totalPrice);

    // notifyListeners();

  }

  Future<void> getValues_from_sharedPrefs() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    _count = sp.getInt("count_value") ?? 0; // if value in sp is null then set to zero
    _totalPrice = sp.getDouble("totalPrice_value") ?? 0.0;

    notifyListeners(); // notifies that change has been made
  }

  void incrementCount(){
    _count++;
    setValues_in_sharedPrefs(); //it will store value of _count in shared pref so it remains in local storage
    notifyListeners();
  }

  void decrementCount(){
    _count--;
    setValues_in_sharedPrefs();
    notifyListeners();
  }



  void incrementTotalPrice(double itemPrice) {
    _totalPrice = _totalPrice + itemPrice;
    setValues_in_sharedPrefs();
    notifyListeners();
  }

  void decrementTotalPrice(double itemPrice){
    _totalPrice = _totalPrice - itemPrice;
    setValues_in_sharedPrefs();
    notifyListeners();
  }

  // Future<int> getCount() async{
  //   await getValues_from_sharedPrefs(); //it will store the modified value in _count from sharedPrefs
  //   return _count;
  // }

  // Future<double> getTotalPrice() async{
  //   await getValues_from_sharedPrefs();
  //   return _totalPrice;
  // }


  //Problem is that we can't call the async functions in normal funcs
//if we do it will act abnormally
// so we will have a separate function to call the getValues func, so that data from shared prefs can be updated in variables.
  Future<void> refreshValues() async{
    await getValues_from_sharedPrefs();
  }

  //fetching data stored in db
  Future<List<Cart>> getCartData() async{
    _cartList = dbHelper!.retrieveData();
    return _cartList;
  }

  //this method is there to check whther a particular item is in cart or not.
  Future<bool> isInCart(int id) async{
    final currentItemsList = await _cartList;

    bool status = currentItemsList.contains(id);

    return status;
  }

}



