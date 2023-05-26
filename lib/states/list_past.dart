// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class List_Past extends StatefulWidget {
  const List_Past({Key? key}) : super(key: key);

  @override
  State<List_Past> createState() => _List_PastState();
}

class _List_PastState extends State<List_Past> {
  bool load = true;
  bool? havedata;
  List<PrefBooking> books = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id')!;
    String apiGetBook =
        '${MyConstant.domain}/goalinter_project/getidfrobook.php?isAdd=true&id=$id';
    await Dio().get(apiGetBook).then((value) {
      print(value);
      if (value.toString() == 'null') {
        // nodata
        setState(() {
          havedata = false;
          load = false;
        });
      } else {
        // havedata
        for (var item in json.decode(value.data)) {
          PrefBooking model = PrefBooking.fromMap(item);
          print('id = ${model.id}');

          setState(() {
            load = false;
            havedata = true;
            books.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
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
                        title: 'No Booking', textStyle: MyConstant().h1Style()),
                  ],
                ),
              );
  }

  Future<Null> showAlertDiaLog(PrefBooking book) async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: ListTile(
                title: ShowTitle(
                  title: book.datetime_start,
                  textStyle: MyConstant().h2Style(),
                ),
                subtitle: ShowTitle(
                  title: book.datetime_end,
                  textStyle: MyConstant().h3Style(),
                ),
              ),
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('OK'))
              ],
            ));
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print('you click index $index');
          showAlertDiaLog(books[index]);
        },
        child: Card(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                width: constraints.maxWidth * 0.5 + 20,
                height: constraints.maxWidth * 0.5 - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShowTitle(
                          title: '⏲️ Time: ',
                          textStyle: MyConstant().h3Style(),
                        ),
                        ShowTitle(
                          title: 'Date: ${books[index].datetime_start}',
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: ' - ',
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: books[index].datetime_end,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
