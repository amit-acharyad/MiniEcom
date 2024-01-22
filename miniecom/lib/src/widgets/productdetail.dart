import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Widget image;
  

  ProductDetail({ required this.image});
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Product Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
        ),
        body: ListView(
          children: [
          image,
          Divider()],
        ));
  }
}
