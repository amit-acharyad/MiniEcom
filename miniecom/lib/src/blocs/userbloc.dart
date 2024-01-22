import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../models/usermodel.dart';

class UserBloc {
  final _userFetcher = BehaviorSubject<String?>();
  final _userOutput = BehaviorSubject<Future<User?>>();

  
}
