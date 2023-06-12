// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goalinter/adminstates/adminbooking.dart';
import 'package:goalinter/adminstates/admininfor_service.dart';
import 'package:goalinter/adminstates/viewmember.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/states/Field_service.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/book_service.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  PrefProfile? profiles;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('id = $id');
    String apiGetUser =
        '${MyConstant.domain}/goalinter_project/getUser.php?isAdd=true&id=$id';
    
    await Dio().get(apiGetUser).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          profiles = PrefProfile.fromMap(item);
          print('user = ${profiles!.firstname}');
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 0, right: 280),
              child: Text(
                "Hello,",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 50),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          profiles == null ? ' ' : profiles!.firstname,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.clear().then((value) =>
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Authen()),
                                    (route) => false));
                          },
                          icon: Icon(
                            Icons.exit_to_app_rounded,
                            color: Color.fromARGB(255, 40, 40, 40),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Image.asset('asset/images/open_admin.jpg', fit: BoxFit.cover),
            ),
                
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminInfor_service()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 201, 201, 201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        textStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.newspaper_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                        Text(
                          'Information',
                          style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Field_service()));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.search_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                        Text(
                          'Field',
                          style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 125, 195, 178),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                        textStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 42, right: 41, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Viewmember_service()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 252, 210, 94),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 41, vertical: 30),
                        textStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.list_alt_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                        Text(
                          'Member',
                          style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Booking_Admin()));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.book_online_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                        Text(
                          'Booking',
                          style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 244, 133, 133),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                        textStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  ],
                ),
              ),

            
          ],
        ),
      ),
    );
  }
}