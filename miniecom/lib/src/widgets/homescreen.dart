import 'package:miniecom/src/models/productmodel.dart';
import 'package:miniecom/src/widgets/productdetail.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../blocs/loginprovider.dart';
import '../resources/userdata.dart';
import '../models/usermodel.dart';

class HomeScreen extends StatelessWidget {
  String? email;
  Widget build(context) {
    final loginBloc = LoginProvider.of(context);
    email = loginBloc.emailController.value;
    return FutureBuilder<User?>(
        future: getUser(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            User? user = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Welcome to Agastya ${user?.name} ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.orange,
                ),
                body: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(child: image1()),
                            onTap: () {
                              print("Tapped on image1 by ${user?.name}");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      image: image1Details(
                                          user?.email, context))));
                            },
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            child: image2(),
                            onTap: () {
                              print("Tapped on image1");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      image: image2Details(user?.email, context))));
                            },
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            child: image3(),
                            onTap: () {
                              print("Tapped on image1");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      image: image3Details(
                                          user?.email, context))));
                            },
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<User?> getUser(String? email) async {
    await userdatabase.init;
    User? user = await userdatabase.fetchUser(email);
    print("Inside Home SCreen");
    print("${user?.name} ${user?.email} ${user?.id} ");
    return user;
  }

  Widget image1() {
    return Column(children: [
      Image(
        image: AssetImage("assets/images/laptop.jpg"),
        fit: BoxFit.contain,
      ),
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
      ),
      Center(
          child: Text("Laptop",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)))
    ]);
  }

  Widget image1Details(email, context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: [
        image1(),
        Center(
            child: Text(
          "HP Laptop i5 10th generation 16 GB RAM 1TB Harddisk.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        Divider(),
        Center(
          child: Text("Price: Rs 70000",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
        ),
        TextButton(
          onPressed: () {
            
            userdatabase.addProduct(ProductModel(
                productName: "Laptop",
                productId: 1,
                email: email,
                productPrice: 70000));
            showCustomDialog(context);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)),
          child: Text(
            "Add to Cart",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ]),
    );
  }

  Widget image2() {
    return Column(children: [
      Image(
        image: AssetImage("assets/images/phone.jpg"),
        fit: BoxFit.contain,
      ),
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
      ),
      Center(
          child: Text("SmartPhone",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)))
    ]);
  }

  Widget image2Details(name, context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: [
        image2(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Center(
            child: Text("Samsung S23 Ultra with 100X zoom.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Center(
          child: Text("Price: Rs 87000",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        TextButton(
          onPressed: () {
            print("Phone added to Cart of $name.");
            userdatabase.addProduct(ProductModel(
                productName: "Smart Phone",
                productId: 2,
                email: email,
                productPrice: 87000));
            showCustomDialog(context);

          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)),
          child: Text(
            "Add to Cart",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ]),
    );
  }

  Widget image3() {
    return Column(children: [
      Image(
        image: AssetImage("assets/images/glass.jpg"),
        fit: BoxFit.contain,
      ),
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
      ),
      Center(
          child: Text("Glasses",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)))
    ]);
  }

  Widget image3Details(name, context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: [
        image3(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Text("LensKart glasses with uv and blue ray protection.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Text("Price: Rs 1200",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
        ),
        TextButton(
          onPressed: () {
            print("Glass added to Cart of $name.");

            userdatabase.addProduct(ProductModel(
                productName: "Glasses",
                productId: 3,
                email: email,
                productPrice: 1200));
            showCustomDialog(context);

          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)),
          child: Text(
            "Add to Cart",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ]),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            
            title: Icon(Icons.check_circle, color: Colors.green),
            content: Text("Order Added Succesfully"),
            actions: [
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK",style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }
}
