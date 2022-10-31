// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, unused_label, prefer_is_empty

import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/addinfor.dart';
import 'package:goalinter/data/information.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfor_Service extends StatefulWidget {
  const EditInfor_Service({Key? key}) : super(key: key);

  @override
  State<EditInfor_Service> createState() => _EditInfor_ServiceState();
}

class _EditInfor_ServiceState extends State<EditInfor_Service> {
  bool load = true;
  bool? havedata;
  List<PrefInformation> informations = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {

    if(informations.length != 0){
      informations.clear();
    } else {
      print('no data');
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id')!;
    String apiGetInfor =
        '${MyConstant.domain}/goalinter_project/getInforWhereIdinfor.php?isAdd=true&id=$id';
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
        title: Text('Edit Information'),
        backgroundColor: MyConstant.gray,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInfor(),
            ),
          ).then((value) => loadValueFormAPI());
          debugPrint("Click FloatingActionButton Button");
        },
        label: Text('Add Information'),
        icon: Icon(Icons.add_circle_outline),
        backgroundColor: MyConstant.dark,
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
                    child: Image.network(
                      Url(informations[index].image),
                      fit: BoxFit.cover,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            print('You Click Edit = $index');
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            print('You Click Delete = $index');
                            confirmDelete(informations[index]);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> confirmDelete(PrefInformation information) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: ListTile(
            leading: Image.network(Url(information.image), fit: BoxFit.cover),
            title: ShowTitle(
              title: 'Are you sure to delete ${information.title} ?',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: information.content,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  print('Delete information = ${information.idinformation}');
                  String apiDelteInfor =
                      '${MyConstant.domain}/goalinter_project/deleteInformation.php?isAdd=true&idinformation=${information.idinformation}';
                  await Dio().get(apiDelteInfor).then((value) {
                    Navigator.pop(context);
                    loadValueFormAPI();
                });
                },
                child: Text('Delete'),
                // onPressed: () => Navigator.pop(context), child: Text('Delete')
                ),
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ]),
    );
  }
}
