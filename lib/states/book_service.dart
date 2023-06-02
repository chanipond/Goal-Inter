// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goalinter/controller/checkbook.dart';
import 'package:goalinter/data/book.dart';
import 'package:goalinter/states/chaeckdate.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book_service extends StatefulWidget {
  const Book_service({Key? key}) : super(key: key);

  @override
  State<Book_service> createState() => _Book_serviceState();
}

class _Book_serviceState extends State<Book_service> {
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  // final CheckbookController checkbook = Get.put(CheckbookController());
  bool checkdate = false;
  bool checkfield = false;
  bool checktime = false;

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  String field = "Null";
  List<String> timeSelect = [];

  List<dynamic> myList = [];
  List<String> dateOnly = [];

  Color testColor = Color.fromARGB(255, 149, 242, 152);

  List<String> time = [
    '17:01 - 18:00',
    '18:01 - 19:00',
    '19:01 - 20:00',
    '20:01 - 21:00',
    '21:01 - 22:00',
    '22:01 - 23:00',
    '23:01 - 23:59',
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

  List<bool> checkColor() {
    for (int i = 0; i < TimeCheckStart.length; i++) {
      for (int j = 0; j < isSelectTime.length; j++) {
       (TimeCheckStart[i] == (time[j].substring(0,5)))?isSelectTime[j] = true:isSelectTime[j] != true;
       (TimeCheckEnd[i] == (time[j].substring(8,13)))?isSelectTime[j] = true:isSelectTime[j] != true;
       j>0&&j<6?isSelectTime[j+1]==true&&isSelectTime[j-1]==true?isSelectTime[j]=true:isSelectTime[j]!=true:null;
       j>1&&j<5?isSelectTime[j+2]==true&&isSelectTime[j-2]==true?isSelectTime[j]=true:isSelectTime[j]!=true:null;
      }
    }
    print("test time ${isSelectTime}");
    return isSelectTime;
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
                          checkColor();
                          if (isSelected3 == false) {
                            field = "3";
                            
                          }

                          checkTime();
                          isSelectTime = [false, false, false, false, false, false, false];
                          
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
                    // Container(
                    //   // color: (index%2==0?Color(0xff73A9AD) : Color.fromARGB(255, 216, 99, 99)),
                    //   color: timeSelect != null ? testColor : Colors.white,

                    //   child: BuildToggle(context),
                    // ),

                    buildbtntime(context),
                    buildbtnbook(size),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Row buildbtntime(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.8,
          height: size * 1.0,
          child: ListView.builder(
            itemCount: time.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (checkFunction(isSelectTime)) {
                        setState(() {
                          isSelectTime[index] = !isSelectTime[index];
                          if (isSelectTime[index]) {
                            timeSelect.add(time[index]);
                            timeSelect.sort();
                          } else {
                            timeSelect.remove(time[index]);
                          }
                        });
                        print(timeSelect);
                      } else {
                        setState(() {
                          timeSelect = [];
                          MyConstant().normalDialog(context,
                              'จองข้ามเวลาไม่ได้', 'กรุณาเลือกเวลาใหม่');
                          isSelectTime = [
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
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    height: size * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: isSelectTime[index]
                      //     ? Color.fromARGB(255, 112, 112, 112)
                      //     : ((checkColor(TimeCheckStart, isSelectTime))
                      //         ? Color.fromARGB(255, 216, 99, 99)
                      //         : Color.fromARGB(255, 149, 242, 152)),
                      color: (!checkColor()[index]
                          ? isSelectTime[index]
                              ? Color.fromARGB(255, 112, 112, 112)
                              : Color.fromARGB(255, 149, 242, 152)
                          : Color.fromARGB(255, 216, 99, 99)),
                    ),
                    child: Center(
                      child: Text(
                        time[index],
                        style: TextStyle(
                          color:
                              isSelectTime[index] ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
         
        ),
      ],
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
                        checkColor();

                        if (isSelected1 == false) {
                          field = "1";
                        }

                        checkTime();
                        isSelectTime = [false, false, false, false, false, false, false];
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
                        checkColor();

                        if (isSelected2 == false) {
                          field = "2";
                        }

                        checkTime();
                        isSelectTime = [false, false, false, false, false, false, false];
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
    String date = dateController.text;
    String typeField = field;
    // String datetime_start = "";
    // String datetime_end = "";

    String datetimeStart =
        (dateController.text + " " + timeSelect[0].split(' - ')[0]).toString();
    String datetimeEnd = (dateController.text +
            " " +
            timeSelect[(timeSelect.length) - 1].split(' - ')[1])
        .toString();

    // String datetime_start =(dateController.text + " " + timeSelect[0].split(' - ')[0]).toString();
    // // for (int i = 0; i < 6; i++) {
    // //   String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    // //    if (i==6){
    // //     String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    // //    } else {
    // //     String datetime_end = dateController.text + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    // //     DateTime nextDay = DateTime.parse(dateController.text).add(Duration(days: 1));
    // //     datetime_end =  nextDay.toString() + " " + timeSelect[(timeSelect.length)-1].split(' - ')[1];
    // //    }
    // // }

    // String datetime_end = (dateController.text +" " +timeSelect[(timeSelect.length) - 1].split(' - ')[1]).toString();
    // String date = dateController.text;

    // String time = timeSelect.toString();

    print('date = $date');

    print(
        'id = $id, firstname = $firstname, lastname = $lastname, datetime_start = $datetimeStart, datetime_end = $datetimeEnd, typeField = $typeField');
    // String path =
    //     '${MyConstant.domain}/goalinter_project/getDatebyAdmin.php?isAdd=true&date=$date';
    // await Dio().get(path).then((value) {

    // Navigator.pushNamed(context, MyConstant.routePay);

    InsertbookToMySQL(
      id: id,
      firstname: firstname,
      lastname: lastname,
      date: date,
      datetime_start: datetimeStart,
      datetime_end: datetimeEnd,
      typeField: typeField,
    );
  }

  Future<Null> InsertbookToMySQL({
    String? id,
    String? firstname,
    String? lastname,
    String? typeField,
    String? date,
    String? datetime_start,
    String? datetime_end,
  }) async {
    String apiinsertField =
        '${MyConstant.domain}/goalinter_project/insertBooking.php?isAdd=true&id=$id&firstname=$firstname&lastname=$lastname&date=$date&datetime_start=$datetime_start&datetime_end=$datetime_end&typeField=$typeField&status=f';
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
  }

  var DBTime = Book_Model().obs;
  List<String> SubStart = [];
  List<String> SubEnd = [];

  List<String> TimeCheckStart = [];
  List<String> TimeCheckEnd = [];

  Future<Null> checkTime() async {
    String typeField = field;
    String date = dateController.text;
    try {
      String apiCheckTime =
          '${MyConstant.domain}/goalinter_project/gettime.php?isAdd=true&date=$date&typeField=$typeField';
      await Dio().get(apiCheckTime).then((value) {
        var result = json.decode(value.data);
        print('result = $result');
        for (var map in result) {
          Book_Model model = Book_Model.fromJson(map);
          DBTime.value = model;
          print('TimeStart = ${DBTime.value.datetimeStart}');
          print('TimeEnd = ${DBTime.value.datetimeEnd}');

          SubStart = DBTime.value.datetimeStart!.split(' ');
          SubEnd = DBTime.value.datetimeEnd!.split(' ');

          print('SubStart = $SubStart');
          print('SubEnd = $SubEnd');

          print('Start = ${SubStart[1].substring(0, 5)}');
          print('End = ${SubEnd[1].substring(0, 5)}');

          TimeCheckStart.add(SubStart[1].substring(0, 5));
          TimeCheckEnd.add(SubEnd[1].substring(0, 5));
        }

        print('TimeCheckStart = $TimeCheckStart');
        print('TimeCheckEnd = $TimeCheckEnd');

        // print('TimeCheck = $TimeCheck');
        // TimeCheck.remove(SubStart[1]);
      });
    } catch (e) {
      print("error = $e");
    }
  }
}
