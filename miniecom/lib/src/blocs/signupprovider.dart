import 'package:flutter/material.dart';

import 'signupbloc.dart';
export 'signupbloc.dart';

class SignupProvider extends InheritedWidget {
  final signupBloc = SignupBloc();
  SignupProvider({Key? key, required Widget child})
      : super(key: key, child: child);
  bool updateShouldNotify(_) => true;
  static SignupBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<SignupProvider>()
            as SignupProvider)
        .signupBloc; 
  }
}
