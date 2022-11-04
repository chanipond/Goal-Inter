// import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, camel_case_types

import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/adminbooking.dart';
import 'package:goalinter/adminstates/admininfor_service.dart';
import 'package:goalinter/adminstates/listbyadmin.dart';
import 'package:goalinter/adminstates/viewmember.dart';
import 'package:goalinter/states/Home.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/contact.dart';
import 'package:goalinter/states/list.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin_Service extends StatefulWidget {
  const Admin_Service({Key? key}) : super(key: key);

  @override
  State<Admin_Service> createState() => _Admin_ServiceState();
}

class _Admin_ServiceState extends State<Admin_Service> {
  int currentIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home_service(),
    ListAdmin_service(),
    Contact_service(),
  ];

  void _onItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(''),
        backgroundColor: MyConstant.gray,
      ),
      drawer: Drawer(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: MyConstant.gray,
                        ),
                        margin: EdgeInsets.all(0.0),
                        child: Center(
                          child: Text("Goal-Inter"),
                        ),
                      ),
                      ListTile(
                        title: Text("Edit Information"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminInfor_service()));
                        },
                      ),
                      ListTile(
                        title: Text("Member"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Viewmember_service()));
                        },
                      ),
                      ListTile(
                        title: Text("Booking"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Booking_Admin()));
                        },
                      ),
                      Expanded(child: SizedBox()),
                      Divider(
                          height: 1.0, color: Color.fromARGB(255, 17, 17, 17)),
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Logout"),
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.clear().then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Authen()),
                                  (route) => false));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyConstant.gray,
        selectedItemColor: MyConstant.white,
        iconSize: 25,
        // selectedFontSize: 18,
        unselectedItemColor: Color.fromARGB(255, 160, 160, 160),
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
