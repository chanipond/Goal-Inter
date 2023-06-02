// import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/states/Field_service.dart';
import 'package:goalinter/states/Home.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/booking_service.dart';
import 'package:goalinter/states/contact.dart';
import 'package:goalinter/states/infor_service.dart';
import 'package:goalinter/states/list.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_service.dart';

class Member_Service extends StatefulWidget {
  const Member_Service({Key? key}) : super(key: key);

  @override
  State<Member_Service> createState() => _Member_ServiceState();
}

class _Member_ServiceState extends State<Member_Service> {
  int currentIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home_service(),
    List_service(),
    Contact_service(),
  ];

  PrefProfile? profiles;

  void _onItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: MyConstant.primary,
        gradient: RadialGradient(
          colors: [MyConstant.white, MyConstant.dark],
          center: Alignment(-0.8, -0.2),
          radius: 1,
        ),
      ),
      accountName: Text(
        profiles == null ? 'Name' : '${profiles!.firstname}',
        style: TextStyle(color: MyConstant.white),
      ),
      accountEmail: Text(profiles == null ? 'Email' : '${profiles!.email}',
          style: TextStyle(color: MyConstant.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(''),
      //   backgroundColor: MyConstant.primary,
      // ),
      // drawer: Drawer(
      //   child: LayoutBuilder(
      //     builder: (context, constraint) {
      //       return SingleChildScrollView(
      //         child: ConstrainedBox(
      //           constraints: BoxConstraints(minHeight: constraint.maxHeight),
      //           child: IntrinsicHeight(
      //             child: Column(
      //               children: <Widget>[
      //                 // DrawerHeader(
      //                 //   decoration: BoxDecoration(
      //                 //     color: MyConstant.primary,
      //                 //   ),
      //                 //   margin: EdgeInsets.all(0.0),
      //                 //   child: Center(
      //                 //     child: Text("Goal-Inter"),
      //                 //   ),

      //                 // ),
      //                 UserAccountsDrawerHeader(
      //                   decoration: BoxDecoration(
      //                     color: MyConstant.primary,
      //                   ),
      //                   accountName: Text(profiles == null
      //                       ? 'firstname'
      //                       : profiles!.firstname),
      //                   accountEmail: Text(profiles == null
      //                       ? 'email'
      //                       : profiles!.email),
      //                 ),
      //                 ListTile(
      //                   title: Text("Information"),
      //                   onTap: () {
      //                     Navigator.of(context).pop();
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 Info_service()));
      //                   },
      //                 ),
      //                 ListTile(
      //                   title: Text("Goal-Inter Football Field"),
      //                   onTap: () {
      //                     Navigator.of(context).pop();
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 Field_service()));
      //                   },
      //                 ),
      //                 ListTile(
      //                   title: Text("Booking"),
      //                   onTap: () {
      //                     Navigator.of(context).pop();
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 Book_service()));
      //                   },
      //                 ),
      //                 Expanded(child: SizedBox()),
      //                 Divider(
      //                     height: 1.0, color: Color.fromARGB(255, 17, 17, 17)),
      //                 ListTile(
      //                   leading: Icon(Icons.exit_to_app),
      //                   title: Text("Logout"),
      //                   onTap: () async {
      //                     SharedPreferences preferences =
      //                         await SharedPreferences.getInstance();
      //                     preferences.clear().then((value) =>
      //                         Navigator.pushAndRemoveUntil(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) => Authen()),
      //                             (route) => false));
      //                   },
      //                 )
      //               ],
      //             ),
      //             // child: ShowSignOut(),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(currentIndex),
        // Text(
        //   "WELCOME",
        //   style: MyConstant().h1Style(),
        // ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Book_service(),
      //       ),
      //     );
      //   },
      //   label: Text('Booking'),
      //   icon: Icon(Icons.add_circle_outline),
      //   backgroundColor: MyConstant.dark,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyConstant.primary,
        selectedItemColor: MyConstant.dark,
        iconSize: 25,
        // selectedFontSize: 18,
        unselectedItemColor: MyConstant.white,
        // unselectedFontSize: 14,
        showUnselectedLabels: false,
        // currentIndex: currentIndex,
        // onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind_rounded),
            label: 'Contact us',
          ),
        ],
        currentIndex: currentIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
