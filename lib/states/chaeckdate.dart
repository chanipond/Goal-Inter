// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/adminbooking.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_progress.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class checkdate_service extends StatefulWidget {
  final PrefBooking? booking;
  const checkdate_service({super.key, this.booking});
  @override
  State<checkdate_service> createState() => _checkdate_serviceState();
}

bool typeField = false;

class _checkdate_serviceState extends State<checkdate_service> {
  // String? typeField;
  bool load = true;
  bool? havedata;
  List<PrefBooking> books = [];
  final formKey = GlobalKey<FormState>();
  String? date = datetest;

  @override
  void initState() {
    super.initState();
    findBook();
  }

  Future<Null> findBook() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id')!;
    // late String date = preferences.getString('date')!;
    // String timeStart = preferences.getString('timeStart')!;
    // String timeEnd = preferences.getString('timeEnd')!;
    print('date = $date');
    String apiGetUser =
        '${MyConstant.domain}/goalinter_project/getcheck.php?isAdd=trueid=$id';
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
        PrefBooking model = PrefBooking.fromMap(item);
          print('date = ${date}');
          // print('timeStart = ${model.time}');
          // print('typeField = ${model.typeField}');
          
          setState(() {
            // print('date = ${item['date']}');
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
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: MyConstant.primary, title: Text("Booking")),
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
                          title: 'No Booking',
                          textStyle: MyConstant().h1Style()),
                    ],
                  ),
                ),
          
    );
  }

//  @override
//   Widget build(BuildContext context) {
//     double size = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar:
//           AppBar(backgroundColor: MyConstant.primary, title: Text("Booking")),
//       body: SafeArea(
//           child: GestureDetector(
//         onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//         behavior: HitTestBehavior.opaque,
//         child: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: load
//           ? ShowProgress()
//           : havedata!
//               ? LayoutBuilder(
//                   builder: (context, constraints) => buildListView(constraints),
//                 )
//               : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ShowTitle(
//                           title: 'No Booking', textStyle: MyConstant().h1Style()),
                          
//                     ],
//                   ),
//                 ),
//           ),
//         ),
//       )),
//     );

//   }

              
              // Text(books == null ? 'No Data' : books!.date),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(books == null ? 'timeStart' : books!.timeStart),
              //     Text(' - '),
              //     Text(books == null ? 'timeEnd' : books!.timeEnd),
              //   ],
              // ),

              // Row(
              //   children: [
              // buildRadioField1(size),
              // buildRadioField2(size),
              // buildRadioField3(size),
              //   ],
              // ),
              

  String Url(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> list = result.split(',');
    String url = '${MyConstant.domain}/goalinter_project${list[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    double size = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: books.length,
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
                    title: 'Date: ${date}',
                    textStyle: MyConstant().h2Style(),
                  ),
                  // ShowTitle(
                  //   title: 'Field: ${widget.booking!.typeField}',
                  //   textStyle: MyConstant().h2Style(),
                  // ),
                  // Row(
                  //   children: [
                  //     ShowTitle(
                  //       title: '⏲️ Time: ',
                  //       textStyle: MyConstant().h3Style(),
                  //     ),
                  //     ShowTitle(
                  //       title: '${widget.booking!.time}',
                  //       textStyle: MyConstant().h3Style(),
                  //     ),
                  //   ],
                  // ),
                  // ShowTitle(
                  //   title: 'Field: ${widget.booking!.typeField}',
                  //   textStyle: MyConstant().h2Style(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          width: size * 0.8,
          child: ShowImage(
            path: MyConstant.imagebook,
          ),
        ),
      ],
    );
  }

  Row buildbook(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().MyButtonStyle(),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/payin');
              if (formKey.currentState!.validate()) {
                booking();
                // if (typeField == null) {
                //   print('non choose field');
                //   MyConstant().normalDialog(
                //       context, 'Non Choose Field', 'Please Choose Field');
                // } else {
                //   print('Process Insert to Database');

                // }
              }
            },
            child: Text(
              'Book',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> booking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String firstname = preferences.getString('firstname')!;
    String date = preferences.getString('date')!;
    String time = preferences.getString('time')!;
    // String date = dateController.text;
    print(
        'id = $id, firstname = $firstname, date = $date, time = $time');
    String path =
        '${MyConstant.domain}/goalinter_project/getDatebyAdmin.php?isAdd=true&date=$date';
    await Dio().get(path).then((value) {
      // var b = jsonDecode(value.data);
      // print(b);
      // print('value = $value');
      if (value.toString() == 'null') {
        print('Have field in my Database');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("This field has been used"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      processInsertMySQL();
    });
  }

  Future<Null> processInsertMySQL() async {
    String apiinsertField =
        '${MyConstant.domain}/goalinter_project/insertField.php?isAdd=true';
    await Dio().get(apiinsertField).then((value) {
      if (value.toString() == 'true') {
        Navigator.pushReplacementNamed(context, '/booking_service');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Insearch Error"),
              actions: <Widget>[
                TextButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
