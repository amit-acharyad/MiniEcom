import 'package:miniecom/src/blocs/mixins/validator.dart';
import 'package:miniecom/src/models/usermodel.dart';
import 'package:miniecom/src/resources/userdata.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/agastyashop.dart';

class LoginBloc extends Validator {
  final emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //sink
  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //stream
  Stream<String> get email => emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  submitData(context) async {
    final validEmail = emailController.value;
    final validPassword = _passwordController.value;
    print("$validEmail,$validPassword");
    // final userdatabase =UserDatabase();
    await userdatabase.init;

    User? user = await userdatabase.fetchUser(validEmail);
    final emailFromDb = user?.email;
    final passwordFromDb = user?.password;
    user?.display();
    print("Email from Db: $emailFromDb and Password: $passwordFromDb");
    if (validEmail == emailFromDb && validPassword == passwordFromDb) {
      display(user);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AmazonShop()));
    } else {
      _showDialog(context);
    }
  }

  dispose() {
    emailController.close();
    _passwordController.close();
  }

  display(user) {
    print("Name:${user.name},Id: ${user.id},email:${user.email}");
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Text('User not identified.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                )),
          ],
        );
      },
    );
  }
}
