// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';

class ListAdmin_service extends StatefulWidget {
  const ListAdmin_service({Key? key}) : super(key: key);

  @override
  State<ListAdmin_service> createState() => _ListAdmin_serviceState();
}

class _ListAdmin_serviceState extends State<ListAdmin_service> {
  bool load = true;
  bool? havedata;
  List<PrefBooking> books = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

    Future<Null> loadValueFormAPI() async {

      if(books.length != 0){
      books.clear();
    } else {
      print('no data');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id')!;
    String apiGetBook =
        '${MyConstant.domain}/goalinter_project/getidbyadmin.php?isAdd=true&status=w';
    await Dio().get(apiGetBook).then((value) {
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
          print('date = ${model.date}');
          
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
    // double size = MediaQuery.of(context).size.width;
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

  String Url(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> list = result.split(',');
    String url = '${MyConstant.domain}/goalinter_project${list[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) => Card(
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
                  ShowTitle(
                    title: 'ID: ${books[index].id}',
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: 'Firstname: ${books[index].firstname}',
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: 'Lastname: ${books[index].lastname}',
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: 'Date: ${books[index].date}',
                    textStyle: MyConstant().h2Style(),
                  ),
                  Row(
                    children: [
                      ShowTitle(
                        title: '⏲️ Time: ',
                        textStyle: MyConstant().h3Style(),
                      ),
                    ShowTitle(
                    title: books[index].time,
                    textStyle: MyConstant().h3Style(),
                    ),
                    ],
                  
                  ),
                  IconButton(
                          onPressed: () {
                            print('You Click Delete = $index');
                            confirmDelete(books[index]);
                          },
                          icon: Icon(Icons.delete)),
                  
                ],
              ),
            ),

            
          ],
        ),
      ),
    );
  }
  Future<Null> confirmDelete(PrefBooking booking) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: ListTile(
            // leading: Image.network(Url(booking.slip), fit: BoxFit.cover),
            title: ShowTitle(
              title: 'Are you sure to delete ${booking.firstname} Date ${booking.date}?',
              textStyle: MyConstant().h2Style(),
            ),
            // subtitle: ShowTitle(
            //   title: information.content,
            //   textStyle: MyConstant().h3Style(),
            // ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  print('Delete information = ${booking.id}');
                  String apiDelteInfor =
                      '${MyConstant.domain}/goalinter_project/deleteBook.php?isAdd=true&id_booking=${booking.id_booking}';
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
