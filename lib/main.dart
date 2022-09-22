import 'package:flutter/material.dart';
import 'package:goalinter/states/Home.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/booking_service.dart';
import 'package:goalinter/states/contact.dart';
import 'package:goalinter/states/create_account.dart';
import 'package:goalinter/states/infor_service.dart';
import 'package:goalinter/states/member_service.dart';
import 'package:goalinter/states/list.dart';
import 'package:goalinter/utillity/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen':(BuildContext context) => Authen(),
  '/create_account':(BuildContext context) => CreateAccount(),
  '/booking_service':(BuildContext context) => Booking_service(),
  '/member_service':(BuildContext context) => Member_Service(),
  '/list':(BuildContext context) => List_service(),
  '/contact':(BuildContext context) => Contact_service(),
  '/home':(BuildContext context) => Home_service(),
  '/infor_service':(BuildContext context) => Info_service(),

  
};

String? initlaRoute;

void main(){
  initlaRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlaRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

