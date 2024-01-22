import 'package:miniecom/src/blocs/loginprovider.dart';
import 'package:miniecom/src/models/productmodel.dart';
import 'package:miniecom/src/widgets/checkout.dart';
import 'package:flutter/material.dart';
import '../models/usermodel.dart';
import '../resources/userdata.dart';

class Cart extends StatelessWidget {
  String? email;
  int cart = 0;
  int totPrice = 0;
  Widget build(context) {
    final loginBloc = LoginProvider.of(context);
    email = loginBloc.emailController.value;
    print(email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: getProduct(email),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      cart += 1;
                      totPrice += snapshot.data?[index]?.productPrice ?? 0;
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              "${snapshot.data?[index]?.productName}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                " Rs ${snapshot.data?[index]?.productPrice}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                            contentPadding: EdgeInsets.only(left:30),
                          ),
                        ],
                      );
                    }));
              } else {
                return Container(
                    margin: EdgeInsets.only(top: 100, left: 30, right: 20),
                    child: Center(
                        child: Text(
                      "No Item on Cart",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )));
              }
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_checkout),
        onPressed: () {
          if (cart == 0) {
            showCustomDialog(context);
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CheckoutScreen(totPrice: totPrice,)));
          }
        },
      ),
    );
  }

  Future<List<ProductModel?>?> getProduct(String? email) async {
    await userdatabase.init;
    List<ProductModel?>? product = await userdatabase.fetchProducts(email);
    print("Inside Cart SCreen");
    return product;
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Oops! Empty Cart",
            ),
            content: Text("Come on.Let's shop something."),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK", style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }
}
