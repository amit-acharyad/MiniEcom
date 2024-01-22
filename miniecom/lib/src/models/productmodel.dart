import 'package:flutter/material.dart';

import 'usermodel.dart';

class ProductModel {
  final String? productName;
  final int? productId;
  final int? productPrice;
  final String? email;
  ProductModel({this.productName, this.productId, this.productPrice,this.email});
  ProductModel.fromDb(Map<String, dynamic> productData)
      : productName = productData["productName"],
        productId = productData["productId"],
        productPrice = productData["productPrice"],
        email=productData["email"];
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "productName": productName,
      "productId": productId,
      "productPrice": productPrice,
      "email":email
    };
  }
}
