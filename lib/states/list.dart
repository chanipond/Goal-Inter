import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/data/slipping.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';

class List_service extends StatefulWidget {
  const List_service({Key? key}) : super(key: key);

  @override
  State<List_service> createState() => _List_serviceState();
}

class _List_serviceState extends State<List_service> {
  bool load = true;
  bool? havedata;
  List<PrefBooking> books = [];
  List<PrefSlip> slips = [];

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
          PrefSlip model = PrefSlip.fromMap(item);
          print('id = ${model.id}');

          setState(() {
            load = false;
            havedata = true;
            slips.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
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
      itemCount: slips.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print('you click index $index');
          showAlertDiaLog(slips[index]);
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
                    ShowTitle(
                          title: '⏲️ Time: ',
                          textStyle: MyConstant().h3Style(),
                        ),
                    ShowTitle(
                      title: (slips[index].datetime_start).toString(),
                      textStyle: MyConstant().h2Style(),
                    ),
                    ShowTitle(
                          title: ' to ',
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: slips[index].datetime_end,
                          textStyle: MyConstant().h2Style(),
                        ),
                    // Row(
                    //   children: [
                    //     ShowTitle(
                    //       title: '⏲️ Time: ',
                    //       textStyle: MyConstant().h3Style(),
                    //     ),
                    //     ShowTitle(
                    //       title: 'Date: ${slips[index].datetime_start}',
                    //       textStyle: MyConstant().h2Style(),
                    //     ),
                    //     ShowTitle(
                    //       title: ' - ',
                    //       textStyle: MyConstant().h2Style(),
                    //     ),
                    //     ShowTitle(
                    //       title: slips[index].datetime_end,
                    //       textStyle: MyConstant().h3Style(),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<Null> showAlertDiaLog(PrefSlip slip) async{
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Image.network('${MyConstant.domain}${slip.slip}'),
          title: ShowTitle(title: 'Price: ${slip.price} THB', textStyle: MyConstant().h2Style(),),
          subtitle: ShowTitle(title: 'Success', textStyle: MyConstant().h4Style(),),
        ),
        children: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      )
    );
  }
}
