import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_signout.dart';
import 'package:goalinter/widgets/show_title.dart';

class Member_Service extends StatefulWidget {
  const Member_Service({Key? key}) : super(key: key);

  @override
  State<Member_Service> createState() => _Member_ServiceState();
}

class _Member_ServiceState extends State<Member_Service> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
      body: Center(
        child: Text(
          "WELCOME",
          style: MyConstant().h1Style(),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(
            backgroundColor: MyConstant.primary,
            selectedItemColor: MyConstant.button, 
            iconSize: 25,
            // selectedFontSize: 18,
            unselectedItemColor: MyConstant.dark,
            // unselectedFontSize: 14,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            ),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'List',
            ),
      ]),
    );
  }
}
