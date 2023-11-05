import 'package:flutter/material.dart';

class mytheme {
  static Color black = Color(0xff383838);
  static Color primarycolor = Color(0xff004181);
  static Color white = Colors.white;
  static Color grey = Color(0xffC8C9CB);

  static ThemeData AppTheme = ThemeData(
      primaryColor: primarycolor,
      appBarTheme: AppBarTheme(
          backgroundColor: mytheme.primarycolor,
          elevation: 0,
          iconTheme: IconThemeData(color: black)),
      textTheme: TextTheme(
        titleLarge:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
        titleMedium:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
        titleSmall:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: white),
      ),

      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primarycolor),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primarycolor,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(size: 30)));
}
