// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/addinfor.dart';
import 'package:goalinter/adminstates/admin_service.dart';
import 'package:goalinter/adminstates/adminbooking.dart';
import 'package:goalinter/adminstates/admininfor_service.dart';
import 'package:goalinter/adminstates/adminpay.dart';
import 'package:goalinter/adminstates/editinfor_service.dart';
import 'package:goalinter/adminstates/listbyadmin.dart';
import 'package:goalinter/adminstates/viewmember.dart';
import 'package:goalinter/states/Home.dart';
import 'package:goalinter/states/authen.dart';
// import 'package:goalinter/states/bookfield.dart';
import 'package:goalinter/states/booking_service.dart';
import 'package:goalinter/states/chaeckdate.dart';
import 'package:goalinter/states/contact.dart';
import 'package:goalinter/states/create_account.dart';
import 'package:goalinter/states/infor_service.dart';
import 'package:goalinter/states/member_service.dart';
import 'package:goalinter/states/list.dart';
import 'package:goalinter/states/payin.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/states/field_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:goalinter/states/book_service.dart';
import 'package:goalinter/states/pay.dart';
import 'package:goalinter/states/list_past.dart';

import 'package:google_fonts/google_fonts.dart';

final Map<String, WidgetBuilder> map = {
  '/authen':(BuildContext context) => Authen(),
  '/create_account':(BuildContext context) => CreateAccount(),
  '/booking_service':(BuildContext context) => Booking_service(),
  '/member_service':(BuildContext context) => Member_Service(),
  '/list':(BuildContext context) => List_service(),
  '/listadmin':(BuildContext context) => ListAdmin_service(),
  '/contact':(BuildContext context) => Contact_service(),
  '/home':(BuildContext context) => Home_service(),
  '/infor_service':(BuildContext context) => Info_service(),
  '/field_service':(BuildContext context) => Field_service(),
  '/admin_service':(BuildContext context) => Admin_Service(),
  '/editinfor_service':(BuildContext context) => EditInfor_Service(),
  '/addinfor_service':(BuildContext context) => AddInfor(),
  '/adminbooking':(BuildContext context) => Booking_Admin(),
  '/payin':(BuildContext context) => UploadImage(),
  '/viewmember':(BuildContext context) => Viewmember_service(),
  '/admininfor_service':(BuildContext context) => AdminInfor_service(),
  '/checkdate':(BuildContext context) =>checkdate_service(),
  '/adminpay':(BuildContext context) => Adminpay(),
  '/book_service':(BuildContext context) => Book_service(),
  '/pay':(BuildContext context) => Pay_service(),
  '/list_past':(BuildContext context) => List_Past(),


  
};

String? initlaRoute;

Future<Null> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userlevel = preferences.getString('userlevel');
  print('userlevel = $userlevel');
  if(userlevel?.isEmpty ?? true) {
    initlaRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (userlevel) {
      case 'a':
        initlaRoute = MyConstant.routeAdmin;
        runApp(MyApp());
        break;
      case 'm':
        initlaRoute = MyConstant.routeMember;
        runApp(MyApp());
        break;
      default:
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      theme: ThemeData(fontFamily: GoogleFonts.kanit().fontFamily),
      routes: map,
      initialRoute: initlaRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
