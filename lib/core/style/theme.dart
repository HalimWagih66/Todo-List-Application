import 'package:flutter/material.dart';

class ThemeApp{
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color(0xffF2F5FF),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: "Poppins",
            color: Colors.blue
        ),
        titleMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        displayMedium: TextStyle(
          fontSize: 19,
          fontFamily: "STC",
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        displayLarge: TextStyle(
            fontSize: 30,
            fontFamily: "Ubuntu",
            fontWeight: FontWeight.w800,
            color: Colors.white
        ),
        labelSmall: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey
        ),
          bodySmall: TextStyle(
              fontSize: 18,
              color: Color(0xbb8d8d8d),
              fontWeight: FontWeight.w600
          ),
        displaySmall: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500
        ),
      )
  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: "Poppins",
            color: Colors.blue
        ),
          titleMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          displayMedium: TextStyle(
              fontSize: 17,
              fontFamily: "STC",
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        displaySmall: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
        labelSmall: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Color(0xff797979),
          fontWeight: FontWeight.w600
        )
      )
  );
}