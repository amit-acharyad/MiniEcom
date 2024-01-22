import 'dart:async';
import 'dart:math';
import 'package:miniecom/src/models/usermodel.dart';
import 'package:miniecom/src/screens/agastyashop.dart';
import 'package:miniecom/src/screens/loginscreen.dart';
import 'package:miniecom/src/widgets/cart.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'mixins/validator.dart';
import '../resources/userdata.dart';
import '../models/usermodel.dart';

class SignupBloc extends Validator {
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmpasswordController = BehaviorSubject<String>();

  /// Sinks
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword =>
      _confirmpasswordController.sink.add;

  ///Streams
  Stream<String> get name => _nameController.stream;
  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmpasswordController.transform(confirmPasswordValidator);

  Stream<bool> get submitValid =>
      Rx.combineLatest3(email, password, confirmPassword, (e, p, c) {
        print("reached here");
        if (p == c) {
          return true;
        } else {
          return false;
        }
      });
 

  submitData(BuildContext context) async {
    final name = _nameController.value;
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    final confirmPassword = _confirmpasswordController.value;

    if (validPassword == confirmPassword) {
      print("password match");
      print(
          "Name:$name, Email: $validEmail, Password:$validPassword, Confirmpassword: $confirmPassword");
      final id = Random().nextInt(900) + 100;
      final user =
          User(email: validEmail, password: validPassword, name: name, id: id);
      await userdatabase.init;
      await userdatabase.addItem(user);
      // await userdatabase.displayAllUsers();
      user.display();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      print("password dont match");
      _showDialog(context);
    }
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
          content: Text('Passwords do not match.'),
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

  dispose() {
    _nameController.close();
    _confirmpasswordController.close();
    _emailController.close();
    _passwordController.close();
  }
}
