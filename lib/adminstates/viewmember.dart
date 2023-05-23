// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_interpolation_to_compose_strings

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

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      
      itemCount: profies.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              // width: constraints.maxWidth * 0.5 - 4,
              // height: constraints.maxWidth * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    height: constraints.maxWidth * 0.18,
                    child: Image.asset('asset/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                    title: profies[index].firstname +
                        ' ' +
                        profies[index].lastname,
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
