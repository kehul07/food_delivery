import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins");
   }

  static TextStyle HeadlineTextFieldStyle(){
    return TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }

  static TextStyle redHeadlineTextFieldStyle(){
    return TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
  static TextStyle LightTextFieldStyle(){
    return TextStyle(
        fontSize: 16,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }

  static TextStyle semiLightTextFieldStyle(){
    return TextStyle(
        fontSize: 14,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }

  static TextStyle semiBoldTextFieldStyle(){
    return TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }

  static TextStyle whiteSemiBoldTextFieldStyle(){
    return TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }

  static TextStyle whiteBoldTextFieldStyle(){
    return TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
}