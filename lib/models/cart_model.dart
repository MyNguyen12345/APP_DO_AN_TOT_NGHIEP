class CartModel {
  CartModel({
    required this.listCart,
    required this.user,
  });
  late final List<ListCart> listCart;
  late final User user;
  
  CartModel.fromJson(Map<String, dynamic> json){
    listCart = List.from(json['listCart']).map((e)=>ListCart.fromJson(e)).toList();
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['listCart'] = listCart.map((e)=>e.toJson()).toList();
    _data['user'] = user.toJson();
    return _data;
  }
}

class ListCart {
  ListCart({
    required this.cartId,
    required this.userId,
    required this.productId,
    required this.amountProduct,
    required this.product,
  });
  late final int cartId;
  late final int userId;
  late final int productId;
  late final int amountProduct;
  late final Product product;
  
  ListCart.fromJson(Map<String, dynamic> json){
    cartId = json['cartId'];
    userId = json['userId'];
    productId = json['productId'];
    amountProduct = json['amountProduct'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cartId'] = cartId;
    _data['userId'] = userId;
    _data['productId'] = productId;
    _data['amountProduct'] = amountProduct;
    _data['product'] = product.toJson();
    return _data;
  }
}

class Product {
  Product({
    required this.productId,
    required this.userId,
    required this.categoryDetailId,
    required this.productName,
    required this.productStatus,
    required this.avatar,
    required this.description,
    required this.amountProduct,
    required this.priceProduct,
    required this.priceDeposit,
    required this.rating,
    required this.userRating,
    required this.listImage,
  });
  late final int productId;
  late final int userId;
  late final int categoryDetailId;
  late final String productName;
  late final String productStatus;
  late final String avatar;
  late final String description;
  late final int amountProduct;
  late final double priceProduct;
  late final double priceDeposit;
  late final double rating;
  late final int userRating;
  late final List<ListImage> listImage;
  
  Product.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    userId = json['userId'];
    categoryDetailId = json['categoryDetailId'];
    productName = json['productName'];
    productStatus = json['productStatus'];
    avatar = json['avatar'];
    description = json['description'];
    amountProduct = json['amountProduct'];
    priceProduct = json['priceProduct'];
    priceDeposit = json['priceDeposit'];
    rating =  json['rating'];
    userRating =  json['userRating'];
    listImage = List.from(json['listImage']).map((e)=>ListImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['userId'] = userId;
    _data['categoryDetailId'] = categoryDetailId;
    _data['productName'] = productName;
    _data['productStatus'] = productStatus;
    _data['avatar'] = avatar;
    _data['description'] = description;
    _data['amountProduct'] = amountProduct;
    _data['priceProduct'] = priceProduct;
    _data['priceDeposit'] = priceDeposit;
    _data['rating'] = rating;
    _data['userRating'] = userRating;
    _data['listImage'] = listImage.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListImage {
  ListImage({
    required this.imageId,
    required this.imageUrl,
  });
  late final int imageId;
  late final String imageUrl;
  
  ListImage.fromJson(Map<String, dynamic> json){
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageId'] = imageId;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.avatar,
    required this.username,
    required this.gender,
    required this.address,
    required this.birthday,
    required this.dateJoin,
    required this.accountStatus,
    required this.phone,
  });
  late final int userId;
  late final String avatar;
  late final String username;
  late final String gender;
  late final String address;
  late final String birthday;
  late final String dateJoin;
  late final String accountStatus;
  late final int phone;
  
  User.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    avatar = json['avatar'];
    username = json['username'];
    gender = json['gender'];
    address = json['address'];
    birthday = json['birthday'];
    dateJoin = json['dateJoin'];
    accountStatus = json['accountStatus'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['avatar'] = avatar;
    _data['username'] = username;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['birthday'] = birthday;
    _data['dateJoin'] = dateJoin;
    _data['accountStatus'] = accountStatus;
    _data['phone'] = phone;
    return _data;
  }
}
// class CartModel {
//   CartModel({
//     required this.cartId,
//     required this.userId,
//     required this.productId,
//     required this.amountProduct,
//     required this.product,
//     required this.user,
//   });
//   late final int cartId;
//   late final int userId;
//   late final int productId;
//   late final int amountProduct;
//   late final Product product;
//   late final User user;
  
//   CartModel.fromJson(Map<String, dynamic> json){
//     cartId = json['cartId'];
//     userId = json['userId'];
//     productId = json['productId'];
//     amountProduct = json['amountProduct'];
//     product = Product.fromJson(json['product']);
//     user = User.fromJson(json['user']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['cartId'] = cartId;
//     _data['userId'] = userId;
//     _data['productId'] = productId;
//     _data['amountProduct'] = amountProduct;
//     _data['product'] = product.toJson();
//     _data['user'] = user.toJson();
//     return _data;
//   }
// }

// class Product {
//   Product({
//     required this.productId,
//     required this.userId,
//     required this.categoryDetailId,
//     required this.productName,
//     required this.productStatus,
//     required this.avatar,
//     required this.description,
//     required this.amountProduct,
//     required this.priceProduct,
//     required this.priceDeposit,
//     required this.listImage,
//   });
//   late final int productId;
//   late final int userId;
//   late final int categoryDetailId;
//   late final String productName;
//   late final String productStatus;
//   late final String avatar;
//   late final String description;
//   late final int amountProduct;
//   late final double priceProduct;
//   late final double priceDeposit;
//   late final List<ListImage> listImage;
  
//   Product.fromJson(Map<String, dynamic> json){
//     productId = json['productId'];
//     userId = json['userId'];
//     categoryDetailId = json['categoryDetailId'];
//     productName = json['productName'];
//     productStatus = json['productStatus'];
//     avatar = json['avatar'];
//     description = json['description'];
//     amountProduct = json['amountProduct'];
//     priceProduct = json['priceProduct'];
//     priceDeposit = json['priceDeposit'];
//     listImage = List.from(json['listImage']).map((e)=>ListImage.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['productId'] = productId;
//     _data['userId'] = userId;
//     _data['categoryDetailId'] = categoryDetailId;
//     _data['productName'] = productName;
//     _data['productStatus'] = productStatus;
//     _data['avatar'] = avatar;
//     _data['description'] = description;
//     _data['amountProduct'] = amountProduct;
//     _data['priceProduct'] = priceProduct;
//     _data['priceDeposit'] = priceDeposit;
//     _data['listImage'] = listImage.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class ListImage {
//   ListImage({
//     required this.imageId,
//     required this.imageUrl,
//   });
//   late final int imageId;
//   late final String imageUrl;
  
//   ListImage.fromJson(Map<String, dynamic> json){
//     imageId = json['imageId'];
//     imageUrl = json['imageUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['imageId'] = imageId;
//     _data['imageUrl'] = imageUrl;
//     return _data;
//   }
// }

// class User {
//   User({
//     required this.userId,
//     required this.avatar,
//     required this.username,
//     required this.gender,
//     required this.address,
//     required this.birthday,
//     required this.dateJoin,
//     required this.accountStatus,
//     required this.phone,
//   });
//   late final int userId;
//   late final String avatar;
//   late final String username;
//   late final String gender;
//   late final String address;
//   late final String birthday;
//   late final String dateJoin;
//   late final String accountStatus;
//   late final int phone;
  
//   User.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     avatar = json['avatar'];
//     username = json['username'];
//     gender = json['gender'];
//     address = json['address'];
//     birthday = json['birthday'];
//     dateJoin = json['dateJoin'];
//     accountStatus = json['accountStatus'];
//     phone = json['phone'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['userId'] = userId;
//     _data['avatar'] = avatar;
//     _data['username'] = username;
//     _data['gender'] = gender;
//     _data['address'] = address;
//     _data['birthday'] = birthday;
//     _data['dateJoin'] = dateJoin;
//     _data['accountStatus'] = accountStatus;
//     _data['phone'] = phone;
//     return _data;
//   }
// }