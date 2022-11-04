// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Viewmember_service extends StatefulWidget {
  const Viewmember_service({Key? key}) : super(key: key);

  @override
  State<Viewmember_service> createState() => _Viewmember_serviceState();
}

class _Viewmember_serviceState extends State<Viewmember_service> {
  bool load = true;
  bool? havedata;
  List<PrefProfile> profies = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? id = preferences.getString('id')!;
    String apiGetUser =
        '${MyConstant.domain}/goalinter_project/getid.php?isAdd=true&userlevel=m';
    await Dio().get(apiGetUser).then((value) {
      if (value.toString() == 'null') {
        // nodata
        setState(() {
          havedata = false;
          load = false;
        });
      } else {
        // havedata
        for (var item in json.decode(value.data)) {
          PrefProfile model = PrefProfile.fromMap(item);
          print('firstname = ${model.firstname}');
          
          setState(() {
            load = false;
            havedata = true;
            profies.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.gray,
        title: Text("Member"),
      ),
      body: load
          ? ShowProgress()
          : havedata!
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                          title: 'No Member',
                          textStyle: MyConstant().h1Style()),
                    ],
                  ),
                ),
          
    );
  }

  String Url(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> list = result.split(',');
    String url = '${MyConstant.domain}/goalinter_project${list[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: profies.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              width: constraints.maxWidth * 0.5 - 4,
              height: constraints.maxWidth * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                    title: profies[index].firstname,
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: profies[index].lastname,
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: profies[index].telephonenumber,
                    textStyle: MyConstant().h3Style(),
                  ),
                  ShowTitle(
                    title: profies[index].email,
                    textStyle: MyConstant().h3Style(),
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
