// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison, sort_child_properties_last, avoid_unnecessary_containers

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// var datetest;

class Booking_service extends StatefulWidget {
  const Booking_service({Key? key, this.time}) : super(key: key);
  final String? time;
  @override
  State<Booking_service> createState() => _Booking_serviceState();
}

// class Item{
//   Item(this.time);
//   String time;
//   bool selected = false;

//   @override
//   String toString() => time;
// }

class _Booking_serviceState extends State<Booking_service> {
  // List data = ['17:00-17:59', '18:00-18:59', '19:00-19:59', '20:00-20:59', '21:00-21:59', '22:00-22:59', '23:00-23:59'];
  // List selectedData = [];
  // bool? value = false;
  // final dataList = <Item>[
  //   Item('17:00-18:00'),
  //   Item('18:00-19:00'),
  //   Item('19:00-20:00'),
  //   Item('20:00-21:00'),
  //   Item('21:00-22:00'),
  //   Item('22:00-23:00'),
  //   Item('23:00-24:00'),
  // ].obs;
  String? typeField;
  String? valueTime;
  // String? valueChoose2;
  List listItem = [
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
    '21:00 - 22:00',
    '22:00 - 23:00',
    '23:00 - 24:00'
  ];

  // final selectedItem = <Item>[].obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: MyConstant.primary, title: Text("Booking")),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildDate(size),
                buildTitle("Please select time"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Time:  '),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                          hint: Text('Time'),
                          value: valueTime,
                          onChanged: (newValue) {
                            setState(() {
                              valueTime = newValue as String?;
                            });
                          },
                          items: listItem.map((valuestart) {
                            return DropdownMenuItem(
                              child: Text(valuestart),
                              value: valuestart,
                            );
                          }).toList(),
                        ),
                        
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('End:  '),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         padding: EdgeInsets.only(left: 16, right: 16),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             borderRadius: BorderRadius.circular(15)),
                //         child: DropdownButton(
                //           hint: Text('TimeEnd'),
                //           value: valueChoose2,
                //           onChanged: (newValue) {
                //             setState(() {
                //               valueChoose2 = newValue as String?;
                //             });
                //           },
                //           items: listItem.map((valueend) {
                //             return DropdownMenuItem(
                //               child: Text(valueend),
                //               value: valueend,
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                buildTitle("Please select field"),
                buildRadioField1(size),
                buildRadioField2(size),
                buildRadioField3(size),

                buildbook(size),
              ],
            ),
          ),
        ),
      )),
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

  Row buildDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextField(
              controller: dateController,
              // validator: (value) {
              // if (value!.isEmpty) {
              //   return 'Please enter date';
              // } else {}
              // },
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), labelText: "Select Date"),
              readOnly: true,
              onTap: (() async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("dd-MM-yyyy").format(pickedDate);
                  setState(() {
                    dateController.text = formattedDate.toString();
                    // datetest = dateController.text;
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

  Row buildRadioField1(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.8,
          child: RadioListTile(
            value: 'field1',
            groupValue: typeField,
            onChanged: (value) {
              setState(() {
                typeField = value as String?;
              });
            },
            title: ShowTitle(
              title: 'Field 1',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioField2(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.8,
          child: RadioListTile(
            value: 'field2',
            groupValue: typeField,
            onChanged: (value) {
              setState(() {
                typeField = value as String?;
              });
            },
            title: ShowTitle(
              title: 'Field 2',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioField3(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.8,
          child: RadioListTile(
            value: 'field3',
            groupValue: typeField,
            onChanged: (value) {
              setState(() {
                typeField = value as String?;
              });
            },
            title: ShowTitle(
              title: 'Field 3',
              textStyle: MyConstant().h3Style(),
            ),
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
              valueTime = valueTime;
              // valueChoose2 = valueChoose2;
              dateController.text = dateController.text;
              // selectedItem.clear();
              // selectedItem.addAll(dataList.where((p0) => p0.selected));
              // print(selectedItem);
              // selectedItem.refresh();
              if (formKey.currentState!.validate()) {

                  
                
                if (typeField == null) {
                  MyConstant().normalDialog(
                      context, 'Non Choose Field', 'Please Choose Field');
                } 
                
                // if (valueChoose2 == null) {
                //   print('non choose timeEnd');
                //   MyConstant().normalDialog(context, 'Non Choose timeEnd',
                //       'Please Choose timeEnd');
                // }
                if (valueTime == null) {
                  MyConstant().normalDialog(context, 'Non Choose time',
                      'Please Choose time');
                }
                
                if(dateController.text.isEmpty){
                  MyConstant().normalDialog(context, 'Non Choose Date', 
                      'Please Choose Date');
                }
                // if( selectedItem.length != null) {
                //   print('non choose time');
                //   MyConstant().normalDialog(
                //       context, 'Non Choose time', 'Please Choose time');
                // }
                else {
                  print('Process Insert to Database');
                  booking();
                }
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
    String lastname = preferences.getString('lastname')!;
    String date = dateController.text;
    String time = valueTime.toString();
    // String timeEnd = valueChoose2.toString();
    // String time = selectedItem.join(', ');
    print(
        'id = $id, firstname = $firstname, lastname = $lastname, date = $date, time = $time, typeField = $typeField');
    String path =
        '${MyConstant.domain}/goalinter_project/getdate.php?isAdd=true&id=$id';
    await Dio().get(path).then((value) {
      // for (var item in json.decode(value.data)) {
      //   setState(() {
      //     print('timeStart = ${item['timeStart']} ');
      //     print('timeEnd = ${item['timeEnd']}');
      //   });
      // }
      // var a = jsonDecode(value.data);
      
      // print(a[1]);
    //  String $a = value.[timeStart];

      // print(a.runtimeType);
      // var b = jsonDecode(value.data);
      // print(b[0][1]);
      
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
      processInsertMySQL(
        id: id,
        firstname: firstname,
        lastname: lastname,
        date: date,
        time: time,
        // timeEnd: timeEnd,
      );
    });
  }

  Future<Null> processInsertMySQL(
      {String? id,
      String? firstname,
      String? lastname,
      String? date,
      String? time,
      // String? timeEnd,
      }) async {
    String apiinsertField =
        '${MyConstant.domain}/goalinter_project/insertDate.php?isAdd=true&id=$id&firstname=$firstname&lastname=$lastname&date=$date&time=$time&typeField=$typeField&status=w';
    await Dio().get(apiinsertField).then((value) {
      if (value.toString() == 'true') {
        Navigator.pushReplacementNamed(context, '/payin');
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

// List<Widget> generateItem() {
//     final result = <Widget>[];
//     for (int i = 0; i < dataList.length; i++) {
//       result.add(CheckboxListTile(
//         value: dataList[i].selected,
//         title: Text(dataList[i].time),
//         onChanged: (v) {
//           dataList[i].selected = v ?? false;
//           dataList.refresh();
//         },

//       ));
//     }

//     return result;
// }

}
