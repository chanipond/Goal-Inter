import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:url_launcher/url_launcher.dart';


class Booking_service extends StatefulWidget {
  const Booking_service({Key? key}) : super(key: key);

  @override
  State<Booking_service> createState() => _Booking_serviceState();
}

class _Booking_serviceState extends State<Booking_service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text("Booking"),
      ),
      body: Center(
        child: 
        Text("Booking Page Commingsoon"),
     ),
    );
  }
}