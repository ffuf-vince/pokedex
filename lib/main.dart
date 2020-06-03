import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pokemon_info_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
      ),
      home: HomeScreen(),
    );
  }
}




