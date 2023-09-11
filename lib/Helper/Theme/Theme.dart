import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme  = ThemeData(

  scaffoldBackgroundColor: Colors.white ,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
  fontFamily: "Cairo",
  textTheme:  const TextTheme(
    bodySmall: TextStyle(fontSize: 14 ,color: Colors.black),
    bodyMedium: TextStyle(fontSize: 16,color: Colors.black),
    bodyLarge: TextStyle(fontSize: 18,color: Colors.black),
    titleSmall: TextStyle(fontSize: 20,color: Colors.black),
    titleLarge: TextStyle(fontSize: 24,color: Colors.black),
    titleMedium: TextStyle(fontSize: 22,color: Colors.black),
    labelMedium: TextStyle(fontSize: 18,color: Colors.white),
    headlineLarge: TextStyle(fontSize: 0,color: Colors.white,fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),

  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 16,color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      )

  ),
  iconTheme: const IconThemeData(
    size: 20,
    color: Colors.black,
  ),
    colorScheme:  ColorScheme.dark(
        background: Colors.grey.shade200,
        onBackground: Colors.white,
        onSecondary: Colors.black,
        secondary: Colors.grey.shade200,
        onPrimary: Colors.black
    )

);

ThemeData darkTheme  = ThemeData(

  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.pink,
  primarySwatch: Colors.pink,
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 14 ,color: Colors.white,fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 16,color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    iconTheme: IconThemeData(
      color: Colors.white
    )

  ),
  iconTheme: const IconThemeData(
      size: 20,
      color: Colors.white,
    ),
  colorScheme:  ColorScheme.dark(
    background: Colors.white12,
    onBackground: Colors.black,
    onSecondary: Colors.pink.shade800,
    secondary: Colors.white24,
    onPrimary: Colors.white
  )
);