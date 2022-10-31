// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking_service extends StatefulWidget {

  @override
  State<Booking_service> createState() => _Booking_serviceState();
}

class Item{
  Item(this.time);
  String time;
  bool selected = false;

  @override
  String toString() => time;
}

class _Booking_serviceState extends State<Booking_service> {
  // List data = ['17:00-17:59', '18:00-18:59', '19:00-19:59', '20:00-20:59', '21:00-21:59', '22:00-22:59', '23:00-23:59'];
  // List selectedData = [];
  // bool? value = false;
  final dataList = <Item>[
    Item('17:00-18:00'),
    Item('18:00-19:00'),
    Item('19:00-20:00'),
    Item('20:00-21:00'),
    Item('21:00-22:00'),
    Item('22:00-23:00'),
    Item('23:00-24:00'),
  ].obs;

  final selectedItem = <Item>[].obs;
  
  String? typeField;
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
                buildImage(size),
                buildTitle("Please select field"),
                buildRadioField1(size),
                buildRadioField2(size),
                buildRadioField3(size),
                buildTitle("Please select time"),
                Obx(()=>Column(children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: generateItem()
                  )
                ],
                )
                ),
                Obx(()=>Text(selectedItem.join(', '))),
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
                  });
                } else {
                  print("Not selected");
                }
              })),
        ),
      ],
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
              selectedItem.clear();
              selectedItem.addAll(dataList.where((p0) => p0.selected));
              print(selectedItem);
              selectedItem.refresh();
              if (formKey.currentState!.validate()) {
                
                if (typeField == null) {
                  print('non choose field');
                  MyConstant().normalDialog(
                      context, 'Non Choose Field', 'Please Choose Field');
                } else {
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
    String date = dateController.text;
    String time = selectedItem.join(', ');
    print(
        'id = $id, firstname = $firstname, date = $date, typeField = $typeField, time = $time');
    String path =
        '${MyConstant.domain}/goalinter_project/getDateWhereDate.php?isAdd=true&date=$date&time=$time&status=w';
    await Dio().get(path).then((value) {
      print('value = $value');
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
        date: date,
        time: time,
      );
    });
  }

  Future<Null> processInsertMySQL({String? id, String? date, String? time}) async {
    String apiinsertField =
        '${MyConstant.domain}/goalinter_project/insertDate.php?isAdd=true&id=$id&date=$date&typeField=$typeField&time=$time&status=w';
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
  
List<Widget> generateItem() {
    final result = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      result.add(CheckboxListTile(
        value: dataList[i].selected,
        title: Text(dataList[i].time),
        onChanged: (v) {
          dataList[i].selected = v ?? false;
          dataList.refresh();
        },
        
      ));
    }
    
    
    return result;
}

}