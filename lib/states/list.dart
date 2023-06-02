// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/data/slipping.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:intl/intl.dart';
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
  final controller = TextEditingController();
  final dateController = TextEditingController();
  bool checkdate = false;
  
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
        ? const ShowProgress()
        : havedata!
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80, bottom: 10),
                      child: ShowTitle(
                        title: 'List Service',
                        textStyle: MyConstant().h1Style(),
                      ),
                    ),
                    buildDate(size),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: Container(
                    //     width: size * 0.9,
                    //     child: TextFormField(
                    //       controller: controller,
                    //       decoration: InputDecoration(
                    //         labelStyle: MyConstant().h3Style(),
                    //         labelText: 'Search',
                    //         prefixIcon: Icon(
                    //           Icons.search,
                    //           color: MyConstant.dark,
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: MyConstant.dark,
                    //           ),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: MyConstant.light,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ShowTitle(
                                        title: 'วันที่จอง',
                                        textStyle: MyConstant().h3Style(),
                                      ),
                                      ShowTitle(
                                        title: slips[index].datetime_start,
                                        textStyle: MyConstant().h3Style(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ShowTitle(
                                        title: 'เวลาที่จอง',
                                        textStyle: MyConstant().h3Style(),
                                      ),
                                      ShowTitle(
                                        title: slips[index].datetime_end,
                                        textStyle: MyConstant().h3Style(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ShowTitle(
                                        title: 'ราคา',
                                        textStyle: MyConstant().h3Style(),
                                      ),
                                      ShowTitle(
                                        title: slips[index].price,
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
                ),
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

  ListView buildListView(BoxConstraints constraints) {
    double size = MediaQuery.of(context).size.height;
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
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
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

  Future<Null> showAlertDiaLog(PrefSlip slip) async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: ListTile(
                leading: Image.network('${MyConstant.domain}${slip.slip}'),
                title: ShowTitle(
                  title: 'Price: ${slip.price} THB',
                  textStyle: MyConstant().h2Style(),
                ),
                subtitle: ShowTitle(
                  title: 'Success',
                  textStyle: MyConstant().h4Style(),
                ),
              ),
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            ));
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
                  firstDate: DateTime.now(),
                  // และถึงวันสุดท้ายจะสัปดาห์นึง ที่สามารถจองได้
                  lastDate: DateTime.now().add(const Duration(days: 6)),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("yyyy-MM-dd").format(pickedDate);
                  setState(() {
                    checkdate = true;
                    dateController.text = formattedDate.toString();
                  });
                } else {
                  print("Not selected");
                  MyConstant().normalDialog(context, 'Non Choose Date', 'Please Choose Date');
                }
              })),
        ),
      ],
    );
  }
}
