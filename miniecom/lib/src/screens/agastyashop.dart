import 'dart:math';
import 'package:miniecom/src/blocs/loginprovider.dart';
import 'package:miniecom/src/widgets/cart.dart';
import 'package:miniecom/src/widgets/homescreen.dart';
import 'package:miniecom/src/widgets/profile.dart';
import 'package:flutter/material.dart';

class AmazonShop extends StatefulWidget {
  createState() {
    return AmazonShopState();
  }
}

class AmazonShopState extends State<AmazonShop> {
  int current_index = 0;
  List<Widget> widgets = [
    HomeScreen(),
    Cart(),
    Profile(),
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.person,
  ];

  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: widgets[current_index],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedFontSize: 15,
          items: List.generate(icons.length, (index) {
            return BottomNavigationBarItem(
              icon: Icon(
                icons[index],
                color: current_index == index ? Colors.black : Colors.white,
                size: current_index == index ? 30.0 : 24.0,
              ),
              label: getTitle(index),
            );
          }),
          backgroundColor: Colors.orange,
          onTap: (value) {
            setState(() {
              current_index = value;
            });
          },
        ),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Cart";
      case 2:
        return "Profile";
      default:
        return "";
    }
  }
}
