// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:http/http.dart' as http;

class AddInfor extends StatefulWidget {
  const AddInfor({Key? key}) : super(key: key);

  @override
  State<AddInfor> createState() => _AddInforState();
}

class _AddInforState extends State<AddInfor> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  

  Future addEditData() async {
    var response = await http.post(
        Uri.parse("http://${MyConstant.domain}/goalinter_project/note/add.php"),
        body: {
          "title": titleController.text,
          "content": contentController.text,
        });
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Information"),
        backgroundColor: MyConstant.gray,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text("ADD"),
              onPressed: () {
                addEditData();
                Navigator.pop(context);
                debugPrint("add success");
              },
              style:  ElevatedButton.styleFrom(
                primary: MyConstant.gray,
                onPrimary: MyConstant.primary,
              ),
          ),
          ),
        ],
      ),
    );
    
  }
}