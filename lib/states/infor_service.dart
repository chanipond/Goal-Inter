// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/information.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info_service extends StatefulWidget {
  const Info_service({Key? key}) : super(key: key);

  @override
  State<Info_service> createState() => _Info_serviceState();
}

class _Info_serviceState extends State<Info_service> {
  bool load = true;
  bool? havedata;
  List<PrefInformation> informations = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id')!;
    String apiGetInfor =
        '${MyConstant.domain}/goalinter_project/getInforWhereIdinfor.php?isAdd=true&id=2';
    await Dio().get(apiGetInfor).then((value) {
      if (value.toString() == 'null') {
        // nodata
        setState(() {
          havedata = false;
          load = false;
        });
      } else {
        // havedata
        for (var item in json.decode(value.data)) {
          PrefInformation model = PrefInformation.fromMap(item);
          print('title = ${model.title}');
          
          setState(() {
            load = false;
            havedata = true;
            informations.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        backgroundColor: MyConstant.primary,
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
                          title: 'No Information',
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
      itemCount: informations.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: constraints.maxWidth * 0.5 - 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ShowTitle(
                  //   title: informations[index].title,
                  //   textStyle: MyConstant().h2Style(),
                  // ),
                  Container(
                    height: constraints.maxWidth * 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(Url(informations[index].image)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
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
                    title: informations[index].title,
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: informations[index].content,
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

