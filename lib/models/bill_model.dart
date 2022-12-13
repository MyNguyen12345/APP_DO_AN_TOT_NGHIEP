class BillModel {
  BillModel({
    required this.billId,
    required this.billStatusId,
    required this.userId,
    required this.dateBill,
    required this.totalPrice,
    required this.addressBill,
    required this.payId,
     this.payStatus,
    required this.listBillDetail,
    required this.pay,
    required this.userInfoDto,
  });
  late final int billId;
  late final int billStatusId;
  late final int userId;
  late final String dateBill;
  late final double totalPrice;
  late final String addressBill;
  late final int payId;
  late final Null payStatus;
  late final List<ListBillDetail> listBillDetail;
  late final Pay pay;
  late final UserInfoDto userInfoDto;
  
  BillModel.fromJson(Map<String, dynamic> json){
    billId = json['billId'];
    billStatusId = json['billStatusId'];
    userId = json['userId'];
    dateBill = json['dateBill'];
    totalPrice = json['totalPrice'];
    addressBill = json['addressBill'];
    payId = json['pay_id'];
    payStatus = null;
    listBillDetail = List.from(json['listBillDetail']).map((e)=>ListBillDetail.fromJson(e)).toList();
    pay = Pay.fromJson(json['pay']);
    userInfoDto = UserInfoDto.fromJson(json['userInfoDto']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billId'] = billId;
    _data['billStatusId'] = billStatusId;
    _data['userId'] = userId;
    _data['dateBill'] = dateBill;
    _data['totalPrice'] = totalPrice;
    _data['addressBill'] = addressBill;
    _data['pay_id'] = payId;
    _data['pay_status'] = payStatus;
    _data['listBillDetail'] = listBillDetail.map((e)=>e.toJson()).toList();
    _data['pay'] = pay.toJson();
    _data['userInfoDto'] = userInfoDto.toJson();
    return _data;
  }
}

class ListBillDetail {
  ListBillDetail({
    required this.billDetailId,
    required this.productId,
    required this.amountBuy,
     this.moneyNow,
    required this.money,
    required this.product,
  });
  late final int billDetailId;
  late final int productId;
  late final int amountBuy;
  late final Null moneyNow;
  late final double money;
  late final Product product;
  
  ListBillDetail.fromJson(Map<String, dynamic> json){
    billDetailId = json['billDetailId'];
    productId = json['productId'];
    amountBuy = json['amountBuy'];
    moneyNow = null;
    money = json['money'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billDetailId'] = billDetailId;
    _data['productId'] = productId;
    _data['amountBuy'] = amountBuy;
    _data['moneyNow'] = moneyNow;
    _data['money'] = money;
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
     this.rating,
     this.userRating,
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
  late final Null rating;
  late final Null userRating;
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
    rating = null;
    userRating = null;
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

class Pay {
  Pay({
    required this.payId,
    required this.payName,
  });
  late final int payId;
  late final String payName;
  
  Pay.fromJson(Map<String, dynamic> json){
    payId = json['payId'];
    payName = json['payName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payId'] = payId;
    _data['payName'] = payName;
    return _data;
  }
}

class UserInfoDto {
  UserInfoDto({
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
  
  UserInfoDto.fromJson(Map<String, dynamic> json){
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