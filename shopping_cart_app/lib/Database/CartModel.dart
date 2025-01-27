class Cart {
  late final int? indexId; //primary key
  final String? productId;
  final String? title;
  final double? initialPrice;
  final double? productPrice;
  final int? quantity;
  final double? rating;
  final String? image;


  //Constructor
  Cart({
    required this.indexId,
    required this.productId,
    required this.title,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.rating,
    required this.image
  });

  //fromMap() method is used to assign value from map to the local variables of class
  Cart.fromMap(Map<dynamic, dynamic> res)
      : indexId = res["indexId"],
        productId = res["productId"],
        title = res["title"],
        initialPrice = res["initialPrice"],
        productPrice = res["productPrice"],
        quantity = res["quantity"],
        rating = res["rating"],
        image = res["image"];

  //toMap() function is used to return a Map consisting of values saved in local variables
  Map<String, Object?> toMap(){
    return {
      "indexId" : indexId,
      "productId": productId,
      "title" : title,
      "initialPrice" : initialPrice,
      "productPrice" : productPrice,
      "quantity" : quantity,
      "rating" : rating,
      "image" : image,
    };

  }





}

