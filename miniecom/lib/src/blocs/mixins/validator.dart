import 'dart:async';

import '../loginprovider.dart';
import '../signupprovider.dart';
import '../signupbloc.dart';
import '../../resources/userdata.dart';

mixin class Validator {
  
  // final nameValidator = StreamTransformer<String, String>.fromHandlers(
  //   handleData: (name, sink) {
  //     if (name.length > 4) {
  //       sink.add(name);
  //     } else {
  //       sink.addError("Invalid Name");
  //     }
  //   },
  // );
  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
    } else {
      sink.addError("Enter a Valid Email");
    }
  });
  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError("Password must be atleast 5 characters long");
    }
  });

  final confirmPasswordValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (confirmPassword, sink) {
    if (confirmPassword.length > 4) {
      sink.add(confirmPassword);
    } else {
      sink.addError("Password must match");
    }
  });
}
