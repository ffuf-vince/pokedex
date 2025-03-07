import 'package:flutter/material.dart';

import 'color.dart';

final kDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: kBackgroundUIColorDark,
  primaryIconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white),
    titleMedium: TextStyle(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  ),
  scaffoldBackgroundColor: kBackgroundUIColorDark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: kFloatingActionButtonColorDark),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kBackgroundUIColor,
  primaryIconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.black),
    titleMedium: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  ),
  scaffoldBackgroundColor: kBackgroundUIColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: kFloatingActionButtonColor),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
);
