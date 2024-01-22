import 'package:miniecom/src/blocs/loginprovider.dart';
import 'package:miniecom/src/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/userdata.dart';
import '../models/usermodel.dart';

class Profile extends StatelessWidget {
  String? email;
  Widget build(context) {
    final loginBloc = LoginProvider.of(context);
    email = loginBloc.emailController.value;
    return FutureBuilder<User?>(
      future: getUser(email), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          User? user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              backgroundColor: Colors.orange,
            ),
            body: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(children: [
                Divider(),
                Icon(
                  Icons.person,
                  size: 40,
                ),
                Divider(),
                Text("${user?.name}",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text("UserName",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text("${user?.email}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("UserId",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text("${user?.id}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.logout),
              onPressed: () {
                _showYesNoDialog(context);
              },
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<User?> getUser(String? email) async {
    await userdatabase.init;
    User? user = await userdatabase.fetchUser(email);
    print("Inside Profile:");
    print("${user?.name} ${user?.email} ${user?.id}");
    return user;
  }

  void _showYesNoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logging Out'),
          content: Text('Do you want really wish to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: Text('No',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),

            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Yes
              },
              child: Text('Yes',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),

            ),
          ],
        );
      },
    ).then((result) {
      if (result != null && result) {
        print('User pressed Yes');
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));

        
      } else {
      print('User pressed No');
      
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));

      }
    });
  }
}
