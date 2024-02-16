import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_screen.dart';

void main() => runApp(GetMaterialApp(
  home: InputScreen(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputScreen(),
    );
  }
}
