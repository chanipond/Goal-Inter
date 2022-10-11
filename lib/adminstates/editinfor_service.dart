// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/addinfor.dart';
import 'package:goalinter/utillity/my_constant.dart';

class EditInfor_Service extends StatefulWidget {
  const EditInfor_Service({Key? key}) : super(key: key);

  @override
  State<EditInfor_Service> createState() => _EditInfor_ServiceState();
}

class _EditInfor_ServiceState extends State<EditInfor_Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Information'),
        backgroundColor: MyConstant.gray,
      ),
      body: Center(
        child: Text('มีอะไรอยากบอกเปล่า'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddInfor(),),);
          debugPrint("Click FloatingActionButton Button");
        },
        label: Text('Add Information'),
        icon: Icon(Icons.add_circle_outline),
        backgroundColor: MyConstant.gray,
      ),
    );
  }
}
