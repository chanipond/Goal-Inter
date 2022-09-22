import 'package:flutter/material.dart';
import 'package:goalinter/states/authen.dart';
import 'package:goalinter/states/booking_service.dart';
import 'package:goalinter/states/contact.dart';
import 'package:goalinter/states/home.dart';
import 'package:goalinter/states/list.dart';
import 'package:goalinter/utillity/my_constant.dart';

class Info_service extends StatefulWidget {
  const Info_service({Key? key}) : super(key: key);

  @override
  State<Info_service> createState() => _Info_serviceState();
}

class _Info_serviceState extends State<Info_service> {
  int currentIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Info_service(),
    Home_service(),
    List_service(),
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
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 220,
              width: double.infinity,
              color: MyConstant.primary,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  CircleAvatar(
                    backgroundImage: AssetImage("asset/images/Logo.png"),
                    radius: 60.0,
                  )
                ],
              ),
            ),
            ListTile(
              tileColor: Color(0xFFF94C66),
              leading: Icon(
                Icons.exit_to_app,
                size: 32,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              title: Text("Logout"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Authen()));
              },
              textColor: Color.fromARGB(255, 253, 253, 253),
            ),
            ListTile(
              title: Text("Information"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Info_service()));
              },
            ),
            ListTile(
              title: Text("Goal-Inter Football Field"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Authen()));
              },
            ),
            ListTile(
              title: Text("Booking"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Booking_service()));
              },
            ),
          ],
        ),
        // child: ShowSignOut(),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Information"),
        ],
      )),

      // child: _widgetOptions.elementAt(currentIndex),

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
