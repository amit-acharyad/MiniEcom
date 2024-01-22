import 'package:flutter/material.dart';

import 'loginbloc.dart';
export 'loginbloc.dart';
import 'dart:async';

class LoginProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  LoginProvider({Key? key, required Widget child})
      : super(key: key, child: child);
  bool updateShouldNotify(_) => true;
  static LoginBloc of( BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LoginProvider>() as LoginProvider).loginBloc;
    
  }
}
