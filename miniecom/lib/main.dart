import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/resources/userdata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await userdatabase.init;
  runApp(App());
}
