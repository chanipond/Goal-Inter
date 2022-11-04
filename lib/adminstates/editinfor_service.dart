
// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goalinter/data/information.dart';

class EditInfor_Service extends StatefulWidget {
  final PrefInformation? information;
  const EditInfor_Service({Key? key, this.information}) : super(key: key);

  @override
  State<EditInfor_Service> createState() => _EditInfor_ServiceState();
}

class _EditInfor_ServiceState extends State<EditInfor_Service> {

  PrefInformation? information;
  
  @override
  void initState() {
    super.initState();
    information = widget.information;
    print('title = ${information!.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Information"),
      ),
      body: Text('title = ${information!.title}'),
      
    );
    
  }
}