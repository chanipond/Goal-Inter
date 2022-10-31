// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new, sort_child_properties_last

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:intl/intl.dart';

class Booking_Admin extends StatefulWidget {
  const Booking_Admin({Key? key}) : super(key: key);

  @override
  State<Booking_Admin> createState() => _Booking_AdminState();
}

class _Booking_AdminState extends State<Booking_Admin> {
  final formKey = GlobalKey<FormState>();
  List<String> chipList = ["Field 1", "Field 2", "Field 3"];
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.gray,
        title: Text("Booking")),
      body: SizedBox(
        width: 380,
        height: 400,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select the field',
                style: MyConstant().h2Style(),
              ),
            ),
            
            Container(
              key: formKey,
                child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              
              children: <Widget>[
                buildDate(size),
                // buildImage(size),
                choiceChipWidget(chipList),
                
              ],
            )),
            Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Container(
                child: ElevatedButton(
                  style: MyConstant().MyButtonStyle(),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                            print('Process Insert to Database');
                            bookingdate();
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
            ),
          ],
        ),
      )
        );
  }

  Future<Null> bookingdate() async {
    String date = dateController.text;
    print(
        'date = $date');
    String path =
        '${MyConstant.domain}/goalinter_project/getDateWhereDate.php?isAdd=true&date=$date';
    await Dio().get(path).then((value) {
      print('value = $value');
      if (value.toString() == 'null') {
        print('Have date in my Database');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("มีการจองแล้วจ้า"),
              actions: <Widget>[
                TextButton(
                  child: Text("T-T"),
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
        date : date,
      );
    });
  }

  Future<Null> processInsertMySQL(
      {String? id,
      String? date
      }) async {
    print('Success');
    String apiinsertDate =
        '${MyConstant.domain}/goalinter_project/insertDate.php?isAdd=true&id=$id&date=$date';
    await Dio().get(apiinsertDate).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("จองไม่สำเร็จ"),
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
    });
  }




  Row buildDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
            child: TextFormField(
            controller : dateController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Select Date"
            ),
            readOnly: true,
            onTap: (() async{
              DateTime? pickedDate = await showDatePicker(context: context,
              initialDate: DateTime.now(),
              firstDate:DateTime.now(),
              lastDate: DateTime(2101), 
              
              );
              if(pickedDate!=null)
              {
                String formattedDate=DateFormat("dd-MM-yyyy").format(pickedDate);
                setState(() 
                {
                  dateController.text=formattedDate.toString();
                }
                );
              }
              else
              {
                 print("Not selected");
              }
              validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter date';
              } else {}
              };
            }),
          ),
          ),
      ],
    );
  }

    Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
          width: size * 0.8,
          child: ShowImage(
            path: MyConstant.imagebook,
          ),
        ),
      ],
    );
  }


}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color.fromARGB(255, 251, 206, 72),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
