// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sort_child_properties_last

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Book_service extends StatefulWidget {
  const Book_service({Key? key}) : super(key: key);

  @override
  State<Book_service> createState() => _Book_serviceState();
}

class _Book_serviceState extends State<Book_service> {
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool checkdate = false;
  bool checkfield = false;
  bool checktime = false;

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  String field = "Null";
  List<String> timeSelect = [];

  late List<dynamic> myList = [];
  Color testColor = Color.fromARGB(255, 149, 242, 152);

  var calTime;

  List<String> time = [
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
    '21:00 - 22:00',
    '22:00 - 23:00',
    '23:00 - 23:59',
  ];

  List<bool> isSelectTime = [false, false, false, false, false, false, false];

  bool checkFunction(List arr) {
    bool check = true;
    for (int i = 0; i < isSelectTime.length - 1; i++) {
      if (arr[i] != arr[i + 1] && check == true) {
        check = false;
      } else if (arr[i] != arr[i + 1] && check == false && arr[i + 1] == true) {
        return false;
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Booking'),
          backgroundColor: MyConstant.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildDate(size),
              Text("\n\nChoose a field\n"),
              buildImage(size),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: size * 0.4,
                  child: InkWell(
                      onTap: () {
                        checkfield = true;
                        isSelected3 = true;
                        print('You Click Field3');

                        value:
                        'Field3';
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = true;
                          isSelected3 = !isSelected3;

                          if (isSelected3 == false) {
                            field = "3";
                          }

                          // print('myList = $myList');
                          // if (myList){

                          // }
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ColorFiltered(
                              colorFilter: isSelected3
                                  ? ColorFilter.mode(
                                      Color.fromARGB(255, 255, 255, 255),
                                      BlendMode.saturation)
                                  : ColorFilter.mode(
                                      Color.fromARGB(0, 200, 18, 18),
                                      BlendMode.color),
                              child: Image.asset(
                                'asset/images/field_book.jpg',
                                fit: BoxFit.cover,
                              )))),
                ),
              ),
              Text("\nField 3\n\n"),

              Visibility(
                visible: checkdate && checkfield,
                child: Column(
                  children: [
                    Text("Choose a time\n"),
                    Container(
                      // color: (index%2==0?Color(0xff73A9AD) : Color.fromARGB(255, 216, 99, 99)),
                      color: timeSelect != null ? testColor : Colors.white,

                      child: BuildToggle(context),
                    ),
                    buildbtnbook(size),
                  ],
                ),
              ),

              // Visibility(
              //   visible: checkdate && checkfield,
              //   child: Column(
              //     children: [
              //       Text("Choose a time\n"),
              //       SizedBox(
              //         height: 460,
              //         child: ListView.builder(
              //           scrollDirection: Axis.vertical,
              //           itemCount: time.length,
              //           itemBuilder: (context, index) => Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Container(
              //               width: 150,
              //               height: 50,
              //               child: ElevatedButton(
              //                 style: ButtonStyle(
              //                   backgroundColor: MaterialStateProperty.all<Color>(
              //                     index%2==0?Color(0xff73A9AD) : Color.fromARGB(255, 216, 99, 99)
              //                   ),
              //                   // side: MaterialStateProperty.all<BorderSide>(
              //                   //   BorderSide(
              //                   //     color: Colors.black,
              //                   //     width: 2,
              //                   //   ),
              //                   // ),

              //                 ),
              //                 onPressed: () {

              //                   checktime = true;
              //                   // timeSelect = time[index];
              //                   // print('You Click ${time[index]}');

              //                   timeStart = time[index].substring(0,5);
              //                   print('timeStart = $timeStart');

              //                   timeEnd = time[index].substring(8,13);
              //                   print('timeEnd = $timeEnd');
              //                 },

              //                 child: Text(time[index]),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       buildbtnbook(size),
              //     ],
              //   ),
              // ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: time.length,
              //     itemBuilder: (context, index) {
              //       return Text(time[index]);
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }

  ToggleButtons BuildToggle(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelectTime,
      // color: myList != null ? testColor : Colors.white,
      direction: Axis.vertical,
      selectedColor: Color.fromARGB(255, 0, 0, 0),
      fillColor: Color.fromARGB(255, 2, 177, 177),
      // renderBorder: false,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('17:00 - 18:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('18:00 - 19:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('19:00 - 20:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('20:00 - 21:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('21:00 - 22:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('22:00 - 23:00'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: Text('23:00 - 23:59'),
        ),
      ],

      onPressed: (int index) {
        if (checkFunction(isSelectTime)) {
          setState(() {
            isSelectTime[index] = !isSelectTime[index];
            if (isSelectTime[index] == true) {
              timeSelect.add(time[index]);
            } else {
              timeSelect.remove(time[index]);
            }
          });
          print(timeSelect);
        } else {
          setState(() {
            timeSelect = [];
            MyConstant().normalDialog(
                context, 'จองข้ามเวลาไม่ได้', 'กรุณาเลือกเวลาใหม่');
            isSelectTime = isSelectTime = [
              false,
              false,
              false,
              false,
              false,
              false,
              false
            ];
          });
        }
      },
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
              decoration: const InputDecoration(icon: Icon(Icons.calendar_today), labelText: "Select Date"),
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
                  String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
                  setState(() {
                    checkdate = true;
                    dateController.text = formattedDate.toString();
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

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: size * 0.4,
                child: InkWell(
                    onTap: () {
                      checkfield = true;
                      isSelected1 = true;
                      print('You Click Field1');

                      setState(() {
                        isSelected1 = !isSelected1;
                        isSelected2 = true;
                        isSelected3 = true;

                        if (isSelected1 == false) {
                          field = "1";
                        }
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ColorFiltered(
                            colorFilter: isSelected1
                                ? ColorFilter.mode(
                                    Color.fromARGB(255, 255, 255, 255),
                                    BlendMode.saturation)
                                : ColorFilter.mode(
                                    Color.fromARGB(0, 200, 18, 18),
                                    BlendMode.color),
                            child: Image.asset(
                              'asset/images/field_book.jpg',
                              fit: BoxFit.cover,
                            )))),
              ),
            ),
            Text("\nField 1\n"),
          ],
        ),
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: size * 0.4,
                child: InkWell(
                    onTap: () {
                      checkfield = true;
                      isSelected2 = true;
                      print('You Click Field2');

                      setState(() {
                        isSelected1 = true;
                        isSelected2 = !isSelected2;
                        isSelected3 = true;

                        if (isSelected2 == false) {
                          field = "2";
                        }
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ColorFiltered(
                            colorFilter: isSelected2
                                ? ColorFilter.mode(
                                    Color.fromARGB(255, 255, 255, 255),
                                    BlendMode.saturation)
                                : ColorFilter.mode(
                                    Color.fromARGB(0, 200, 18, 18),
                                    BlendMode.color),
                            child: Image.asset(
                              'asset/images/field_book.jpg',
                              fit: BoxFit.cover,
                            )))),
              ),
            ),
            Text("\nField 2\n"),
          ],
        ),
      ],
    );
  }

  Row buildbtnbook(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: size * 0.8,
        child: ElevatedButton(
          style: MyConstant().MyButtonStyle(),
          onPressed: () {
            dateController.text = dateController.text;
            if (dateController.text.isEmpty) {
              MyConstant().normalDialog(
                  context, 'Non Choose Date', 'Please Choose Date');
            } else {
              print('You Click Book');
              print(
                  'DateTime_Start = ${dateController.text + " " + timeSelect[0].split(' - ')[0]},DateTime_End = ${dateController.text + " " + timeSelect[(timeSelect.length) - 1].split(' - ')[1]}, Field = ${field}, ');
            }

            if (checkfield == true && checkdate == true) {
              print('You Click Book');
              // Navigator.pushNamed(context, MyConstant.routePay);
              booking();

              // Color colorTime() {
              //   if (myList != null) {
              //     if (myList[0] == time[0]) {
              //       testColor = Colors.red;
              //     } else if (myList[1] == time[1]) {
              //       testColor = Colors.red;
              //     } else if (myList[2] == time[2]) {
              //       testColor = Colors.red;
              //     } else if (myList[3] == time[3]) {
              //       testColor = Colors.red;
              //     } else if (myList[4] == time[4]) {
              //       testColor = Colors.red;
              //     } else if (myList[5] == time[5]) {
              //       testColor = Colors.red;
              //     } else if (myList[6] == time[6]) {
              //       testColor = Colors.red;
              //     }
              //     testColor = Color.fromARGB(255, 155, 155, 155);
              //   } else {
              //     testColor = Color.fromARGB(255, 155, 155, 155);
              //   }
              //   return testColor;
              // }
            } else {
              MyConstant().normalDialog(
                  context, 'Non Choose Field', 'Please Choose Field');
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
    ]);
  }

  Future<Null> booking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String firstname = preferences.getString('firstname')!;
    String lastname = preferences.getString('lastname')!;
    String datetime_start = (dateController.text + " " + timeSelect[0].split(' - ')[0]).toString();
    // for (int i = 0; i < 6; i++) {
    //   String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    //    if (i==6){
    //     String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    //    } else {
    //     String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    //     DateTime nextDay = DateTime.parse(dateController.text).add(Duration(days: 1));
    //     datetime_end =  nextDay.toString() + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    //    }
    // }
    String datetime_end = (dateController.text +" " +timeSelect[(timeSelect.length) - 1].split(' - ')[1]).toString();
    // String date = dateController.text;
    String typeField = field;
    // String time = timeSelect.toString();

    print(
        'id = $id, firstname = $firstname, lastname = $lastname, datetime_start = $datetime_start, datetime_end = $datetime_end, typeField = $typeField');
    // String path =
    //     '${MyConstant.domain}/goalinter_project/getDatebyAdmin.php?isAdd=true&date=$date';
    // await Dio().get(path).then((value) {

    // Navigator.pushNamed(context, MyConstant.routePay);

    InsertbookToMySQL(
      id: id,
      firstname: firstname,
      lastname: lastname,
      datetime_start: datetime_start,
      datetime_end: datetime_end,
      typeField: typeField,
    );
  }

  Future<Null> InsertbookToMySQL({
    String? id,
    String? firstname,
    String? lastname,
    String? typeField,
    String? datetime_start,
    String? datetime_end,
  }) async {
    String apiinsertField =
        '${MyConstant.domain}/goalinter_project/insertBooking.php?isAdd=true&id=$id&firstname=$firstname&lastname=$lastname&datetime_start=$datetime_start&datetime_end=$datetime_end&typeField=$typeField&status=f';
    await Dio().get(apiinsertField).then((value) {
      if (value.toString() == 'true') {
        Navigator.pushReplacementNamed(context, '/pay');
      } else if (value.toString() == 'Time is overlap') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("เวลาที่เลือกซ้ำกับการจองอื่น"),
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

    // Future<Null> checkTime() async {
    //   String date = dateController.text;
    //   String typeField = field;
    //   String apiGetTime =
    //       '${MyConstant.domain}/goalinter_project/gettime.php?isAdd=true&date=$date&typeField=$typeField';
    //   await Dio().get(apiGetTime).then((value) {
    //     String DBTime = value.toString();
    //     if (DBTime.length >= 13) {
    //       myList = DBTime.split(",");
    //     }

    //     print('DBTime = $DBTime');
    //     print('myList = ${myList[1]}');

    //   });
    // }
  }
}
