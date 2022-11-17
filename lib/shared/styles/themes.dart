import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme(context) => ThemeData(
  scaffoldBackgroundColor: Colors.black87,
  //هاي تمسح فرق اللون بين اب بار و سكفلود
  // ignore: prefer_const_constructors
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.redAccent,
  ),
  textTheme:  TextTheme(
    bodyText2: TextStyle(
      color: Colors.blue,
    ),
      bodyText1: TextStyle(
    color: Colors.white,
  )),
  appBarTheme: AppBarTheme(
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black87, //هذا لون اطار الاشعارات الي فوف فوق
        statusBarIconBrightness: Brightness.light, //هذا وضع الايقونات
      ),

      // ignore: prefer_const_constructors
      // titleTextStyle: Theme.of(context).textTheme.caption!.copyWith
      //   (
      //   //هذا بكون ثابت لكل البرنامج
      //   color: Colors.white,
      //   fontSize: 20.0,
      //   fontWeight: FontWeight.bold,
      // )

      backgroundColor: Colors.black87,
      // ignore: deprecated_member_use
      backwardsCompatibility: false,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        //تعديل على الايقوانات الي في العنوان فوق
        color: Colors.white,
      )),
  iconTheme: IconThemeData(color: Colors.white),
  // ignore: prefer_const_constructors
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: Colors.amber,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.grey[800], //لون الايقونات
  ),
   // fontFamily: 'Loew'
);

ThemeData ligthTheme(context) =>ThemeData(
  scaffoldBackgroundColor: Color(0xffffffff),
  //لون شاشة التطبيق
  // ignore: prefer_const_constructors
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.lightGreen,
  ),
  iconTheme: IconThemeData(color: Colors.black),
  appBarTheme: const AppBarTheme(
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: tabColor, //هذا لون اطار الاشعارات الي فوف فوق
        statusBarIconBrightness: Brightness.dark, //هذا وضع الايقونات
      ),
      // ignore: prefer_const_constructors
      backgroundColor: tabColor,
      // ignore: deprecated_member_use
      backwardsCompatibility: false,
      elevation: 0.0,),
  // ignore: prefer_const_constructors
  // textTheme: TextTheme(
  //     bodyText2: TextStyle(
  //   color: Colors.blue,
  // )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: Colors.amberAccent, //لون الايقونات
    unselectedItemColor: Colors.grey,
  ),
 // fontFamily: 'Loew'
);
