import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'GoalInter';
  // static String ipAddress ='10.34.5.76';
  static String domain = 'https://7a23-110-171-14-206.ap.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/create_account';
  static String routeMember = '/member_service';
  static String routeBooking = '/booking_service';
  static String routeAdmin = '/admin_service ';

  // Image
  static String image1 = 'asset/images/LOGO.png';
  static String imagehome = 'asset/images/Goal2.jpg';
  static String imagecontact = 'asset/images/contact.jpg';
  static String imageface = 'asset/images/facebook.png';

  // Color
  static Color primary = Color(0xff73A9AD);
  static Color dark = Color(0xff2C3333);
  static Color ligth = Color(0xff395B64);
  static Color button = Color(0xffFEF9A7);
  static Color white = Color.fromARGB(255, 255, 255, 255);
  static Color gray = Color.fromARGB(255, 212, 212, 212);

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 25,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 16,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle MyButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  ButtonStyle MyButton2Style() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
