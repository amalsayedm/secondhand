
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme=ThemeData(
    primarySwatch: Colors.deepOrange,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange,unselectedItemColor: Colors.grey),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange),
    textTheme: TextTheme(bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
        color:Colors.black)),fontFamily:'ubuntu');

ThemeData darkTheme=ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange,
        backgroundColor: HexColor('33739'),
        unselectedItemColor: Colors.grey),
    scaffoldBackgroundColor: HexColor('33739'),
    primarySwatch: Colors.deepOrange,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: HexColor('33739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('33739'),
          statusBarIconBrightness: Brightness.light),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange),
    textTheme: TextTheme(bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
        color:Colors.white)),fontFamily:'ubuntu' );
