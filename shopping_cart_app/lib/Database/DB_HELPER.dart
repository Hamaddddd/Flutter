import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'CartModel.dart';

class DBHelper {

  // ? is used to specify null safety that the value can't be null

  static Database? _db; //Database instance

  Future<Database?> get db async {
    // if no database created then create one
    if (_db == null) {
      _db = await initDatabase(); //db created and assigned to _db (method below)
    }

    return _db; //else return the already created one
  }

  //this method creates directory in phone storage for database
  initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "cart.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  //this method will be used to execute the sql query that will create table "cart"
  //also it will specify the values to store in table in the query such as : id,title etc.
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE cart (indexId INTEGER PRIMARY KEY , productId VARCHAR UNIQUE , title TEXT , initialPrice REAL , productPrice REAL , quantity INTEGER , rating REAL , image TEXT)"
    );
  }

  //this method as its name shows is used to insert values inside the database table
  Future<Cart> insert(Cart cart) async{
    var dbClient = await db; //making copy of db
    await dbClient!.insert("cart", cart.toMap());   //Storing values from Cart Model to cart db
    return cart;
  }

  //A method to retrieve the data in list form that is stored in DB, so that it can be displayed on Cart Screen.
  Future<List<Cart>> retrieveData() async{

    var dbClient = await db;
    //querying the cart table and storing data in list form of type map having key value pairs.
    final List<Map<String, Object?>> queryResult = await dbClient!.query("cart");

    //mapping the query result to Cart and then it stores data in its class variables fromMap.
    //And returning the mapped result in list form --type Cart.
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  //this method deletes record for the id specified from with in the table
  //returns the number of rows affected/deleted in database
  Future<int> deleteItem(int id) async{
    var dbClient = await db;

    return await dbClient!.delete(
        'cart', where: 'indexId = ?', whereArgs: [id]
    );
  }

  // A method to update values in database
  // in thhis method local values in Map form are assigned to the Database table named cart

  Future<int> updateQuantity(Cart cart) async{
    var dbClient = await db;

    return dbClient!.update(
        "cart",
        cart.toMap(),
        where: "indexId = ?",
        whereArgs: [cart.indexId]
    );
  }

}
