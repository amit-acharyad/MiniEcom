import 'package:miniecom/src/blocs/loginprovider.dart';
import 'package:miniecom/src/screens/agastyashop.dart';
import 'package:miniecom/src/widgets/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../resources/userdata.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  int totPrice;

  CheckoutScreen({required this.totPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? email;
  String location = '';

  Widget build(BuildContext context) {
    final loginBloc = LoginProvider.of(context);
    email = loginBloc.emailController.value;
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 25, right: 25, top: 50),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Price"),
                    SizedBox(width: 10),
                    Text("Rs ${widget.totPrice}"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text('Choose your preferred location for delivery')),
              SizedBox(height: 10),
              Center(child: locationAsk()),
              SizedBox(height: 10),
              Text("Payment"),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (location != "") {
                            launchUrl(Uri.parse("https://www.google.com"));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Please Select Your Delivery Location"),
                                    actions: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(Icons.close_rounded),
                                          label: Text("Close"))
                                    ],
                                  );
                                });
                          }
                        },
                        child: Text("Pay Online",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange))),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        showCustomDialog(context);
                      },
                      child: Text("Cash On Delivery",
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget locationAsk() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            print("Naxal");
            setState(() {
              location = "Naxal";
            });
          },
          child: Text(
            "Naxal",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: location == "Naxal"
                  ? MaterialStateProperty.all(Colors.blue)
                  : MaterialStateProperty.all(Colors.orange)),
        ),
        SizedBox(width: 10),
        TextButton(
          onPressed: () {
            print("New Baneshwor");
            setState(() {
              location = "New Baneshwor";
            });
          },
          child: Text(
            "New Baneshwor",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: location == "New Baneshwor"
                  ? MaterialStateProperty.all(Colors.blue)
                  : MaterialStateProperty.all(Colors.orange)),
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (location != "") {
            return AlertDialog(
              title: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              content: Text(
                "Your Order has been received.You will be notified about the delivery on the basis of your selected location.\n Thank You for Shopping with us!!!.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    onPressed: () async {
                      await userdatabase.clearOrderByEmail(email);
                      // Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AmazonShop()));
                    },
                    child: Text("OK", style: TextStyle(color: Colors.white)))
              ],
              titleTextStyle: TextStyle(color: Colors.white),
              contentTextStyle: TextStyle(color: Colors.white),
            );
          } else {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                "Please select your preferred delivery location.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK", style: TextStyle(color: Colors.white)))
              ],
              titleTextStyle: TextStyle(color: Colors.white),
              contentTextStyle: TextStyle(color: Colors.white),
            );
          }
        });
  }
}
