// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/data/slip.dart';
import 'package:goalinter/data/slipping.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:intl/intl.dart';
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
  List<PrefSlip> slips = [];

  final controller = TextEditingController();
  final dateController = TextEditingController();
  bool checkdate = false;

  var DBTime = Slip_Model().obs;

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {
    if (slips.length != 0) {
      slips.clear();
    } else {
      print('no data');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? id = preferences.getString('id')!;
    String date = dateController.text;
    try {
      String apiGetBook =
          '${MyConstant.domain}/goalinter_project/getdateforlist.php?isAdd=true&date=$date';
      // String apiGetBook =
      //     '${MyConstant.domain}/goalinter_project/getidbyadmin.php?isAdd=true&status=w';
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
            PrefSlip model = PrefSlip.fromMap(item);
            print('date = ${model.date}');

            setState(() {
              load = false;
              havedata = true;
              slips.add(model);
            });
          }
        }
      });
    } catch (e) {
      print('error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    // return load
    //       ? ShowProgress()
    //       : havedata!
    //           ? LayoutBuilder(
    //               builder: (context, constraints) => buildListView(constraints),
    //             )
    //           : Center(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   ShowTitle(
    //                       title: 'No Booking', textStyle: MyConstant().h1Style()),

    //                 ],
    //               ),
    //             );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: ShowTitle(
                title: 'List Service',
                textStyle: MyConstant().h1Style(),
              ),
            ),
            buildDate(size),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                width: size * 0.3,
                child: ElevatedButton(
                  style: MyConstant().MyButton2Style(),
                  onPressed: () {
                    dateController.text = dateController.text;
                    if (dateController.text.isEmpty) {
                      MyConstant().normalDialog(
                          context, 'Non Choose Date', 'Please Choose Date');
                    } else {
                      print('You Click Book');
                    }
                    loadValueFormAPI();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                      ),
                      Text('Search'),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: checkdate,
              child: Column(
                children: [
                  load
                      ? ShowProgress()
                      : havedata!
                          // ? LayoutBuilder(
                          //     builder: (context, constraints) =>
                          //         buildListView(constraints),
                          //   )
                          // : Center(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         ShowTitle(
                          //             title: 'No Booking',
                          //             textStyle: MyConstant().h1Style()),
                          //       ],
                          //     ),
                          //   ),

                          ? SingleChildScrollView(
                              child: listslip(size),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShowTitle(
                                      title: 'No Booking',
                                      textStyle: MyConstant().h1Style()),
                                ],
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column listslip(double size) {
    return Column(
      children: [
        Container(
          width: size * 0.9,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: slips.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                print('you click index $index');
                showAlertDiaLog(slips[index]);
              },
              child: Card(
                color: (index % 2 == 0
                    ? Color.fromARGB(255, 196, 243, 247)
                    : Color.fromARGB(255, 207, 205, 205)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShowTitle(
                            title: 'Date',
                            textStyle: MyConstant().h3Style(),
                          ),
                          ShowTitle(
                            title: slips[index].date,
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShowTitle(
                            title: 'Time',
                            textStyle: MyConstant().h3Style(),
                          ),
                          ShowTitle(
                            title: (slips[index].datetime_start)
                                    .substring(11, 16) +
                                " - " +
                                (slips[index].datetime_end).substring(11, 16),
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShowTitle(
                            title: 'Field',
                            textStyle: MyConstant().h3Style(),
                          ),
                          ShowTitle(
                            title: slips[index].typeField,
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> confirmDelete(PrefSlip slip) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: ListTile(
            // leading: Image.network(Url(booking.slip), fit: BoxFit.cover),
            title: ShowTitle(
              title:
                  'Are you sure to delete Date ${slip.date} Price ${slip.price} THB ?',
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
                print('Delete information = ${slip.id_slip}');
                String apiDelteInfor = '${MyConstant.domain}/goalinter_project/deleteBook.php?isAdd=true&id_slip=${slip.id_slip}';
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

  Row buildDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextField(
              controller: dateController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), labelText: "Select Date"),
              readOnly: true,
              onTap: (() async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("yyyy-MM-dd").format(pickedDate);
                  setState(() {
                    checkdate = true;
                    dateController.text = formattedDate.toString();
                    print(dateController.text);
                  });
                } else {
                  print("Not selected");
                  MyConstant().normalDialog(
                      context, 'Non Choose Date', 'Please Choose Date');
                }
              })),
        ),
      ],
    );
  }

  Future<Null> showAlertDiaLog(PrefSlip slip) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: ListTile(
                  title: ShowTitle(
                    title: 'Price: ${slip.price} THB',
                    textStyle: MyConstant().h2Style(),
                  ),
                  subtitle: ShowTitle(
                    title: 'Success',
                    textStyle: MyConstant().h4Style(),
                  ),
                ),
                content: Image.network('${MyConstant.domain}${slip.slip}',
                    fit: BoxFit.cover),
                actions: [
                  TextButton(
                    onPressed: () async {
                      confirmDelete(slip);
                      
                    },
                    child: Text('Delete'),
                  ),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                ]

                ));
  }
}
