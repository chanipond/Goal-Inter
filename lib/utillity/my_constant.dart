// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goalinter/widgets/show_image.dart';

class MyConstant {
  // Genernal
  static String appName = 'GoalInter';
    // cmd: ngrok http 80
  static String domain = 'https://eecc-2001-fb1-3c-8739-5072-6e23-a491-cd79.ngrok-free.app';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/create_account';
  static String routeMember = '/member_service';
  static String routeAdmin = '/admin_service';
  static String routeBooking = '/booking_service';
  static String routePay = '/pay';

  // Image
  static String image1 = 'asset/images/LOGO.png';
  static String imagehome = 'asset/images/Goal2.jpg';
  static String imagecontact = 'asset/images/contact.jpg';
  static String imageface = 'asset/images/facebook.png';
  static String imageaddpic = 'asset/images/add-image.png';
  static String imagepic = 'asset/images/image.png';
  static String imagebook = 'asset/images/book.jpg';
  static String imagepay = 'asset/images/payment.png';
  static String imagefield = 'asset/images/field_book.jpg';

  // Color
  static Color primary = Color(0xff73A9AD);
  static Color dark = Color(0xff2C3333);
  static Color ligth = Color(0xff395B64);
  static Color button = Color(0xffFEF9A7);
  static Color white = Color.fromARGB(255, 255, 255, 255);
  static Color gray = Color.fromARGB(255, 212, 212, 212);
  static Color error = Color.fromARGB(255, 196, 23, 23);

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

  //Dialog
  Future<Null> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: 
          Center(
            child: CircularProgressIndicator(
            color: Colors.white,
            ),
          ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: Text(
            title,
            style: TextStyle(color: MyConstant.dark),
          ),
          subtitle: Text(
            message,
            style: TextStyle(color: MyConstant.dark),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
      
  }


}
