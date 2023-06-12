// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/states/Field_service.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/book_service.dart';
import 'package:goalinter/states/infor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';

class Home_service extends StatefulWidget {
  const Home_service({Key? key}) : super(key: key);

  @override
  State<Home_service> createState() => _Home_serviceState();
}

class _Home_serviceState extends State<Home_service> {
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
              child: Image.asset('asset/images/open.jpg', fit: BoxFit.cover),
            ),
                
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Info_service()));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.newspaper_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                        Text(
                          'Informations',
                          style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 201, 201, 201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        textStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
              padding: const EdgeInsets.only(left: 0, right: 170, top: 20, bottom: 50),
              child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Book_service()));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.bookmark_add_rounded, color: Color.fromARGB(255, 26, 26, 26), size: 50),
                          Text(
                            'Booking',
                            style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 235, 217, 128),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                          textStyle:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
