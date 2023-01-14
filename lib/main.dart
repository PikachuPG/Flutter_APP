import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stateful_app/details.dart';
import 'package:stateful_app/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return const MaterialApp(
      title: '3.2 Flutter Push Pop',
      themeMode: ThemeMode.system,
      home: MyForm(),
    );
  }
}