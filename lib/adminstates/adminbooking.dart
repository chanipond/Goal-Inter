// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new, sort_child_properties_last

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:goalinter/data/booking.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var datetest;
var timetest;
var fieldtest;

class Booking_Admin extends StatefulWidget {
  const Booking_Admin({Key? key, this.time}) : super(key: key);
  final String? time;
  @override
  State<Booking_Admin> createState() => _Booking_AdminState();
}

class _Booking_AdminState extends State<Booking_Admin> {
  String? typeField;
  String? valueTime;
  List listItem = [
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
    '21:00 - 22:00',
    '22:00 - 23:00',
    '23:00 - 24:00'
  ];
  

  final formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(
            // actions: [
            //   CheckDate(),
            // ],
            backgroundColor: MyConstant.gray, 
            title: Text("Booking"), 
          ),
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
                              timetest = valueTime;
                            });
                          },
                          items: listItem.map((valueTime) {
                            return DropdownMenuItem(
                              child: Text(valueTime),
                              value: valueTime,
                            );
                          }).toList(),
                        ),
                        
                      ),
                    ),
                  ],
                ),
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

  // IconButton CheckDate() {
  //   return IconButton(
  //     onPressed: () {
  //           print('Check Date');
  //           // Navigator.pushReplacementNamed(context, '/checkdate');
  //           // uploadPictureAndInsertData();
  //     },
  //     icon: Icon(Icons.date_range_outlined),
  //   );
  // }

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
                    datetest = dateController.text;
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
                fieldtest = typeField;
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
                fieldtest = typeField;
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
                fieldtest = typeField;
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
              
              if (formKey.currentState!.validate()) {

                  
                
                if (typeField == null) {
                  MyConstant().normalDialog(
                      context, 'Non Choose Field', 'Please Choose Field');
                } 
                
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
        '${MyConstant.domain}/goalinter_project/getDatebyAdmin.php?isAdd=true&status=w';
    await Dio().get(path).then((value) {
      
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
                    // Navigator.pushReplacementNamed(context, '/adminpay');
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
        // for( var time in listItem){
        //         if(valueTime == time){
        //           print('true');
        //           print(valueTime);
        //           print(listItem);
        //           print(listItem.indexOf(time));
        //           listItem.removeAt(listItem.indexOf(time));
        //           print(listItem);
              
        //         }else{
        //           print('false');
        //           print(valueTime);
        //           print(time);
                  
        //         }
        //       }
        Navigator.pushReplacementNamed(context, '/adminpay');
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



// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:goalinter/utillity/my_constant.dart';
// import 'package:goalinter/widgets/show_image.dart';
// import 'package:intl/intl.dart';

// class  extends StatefulWidget {
//   const Booking_Admin({Key? key}) : super(key: key);

//   @override
//   State<Booking_Admin> createState() => _Booking_AdminState();
// }

// class _Booking_AdminState extends State<Booking_Admin> {
//   final formKey = GlobalKey<FormState>();
//   List<String> chipList = ["Field 1", "Field 2", "Field 3"];
//   TextEditingController dateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double size = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyConstant.gray,
//         title: Text("Booking")),
//       body: SizedBox(
//         width: 380,
//         height: 400,
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Select the field',
//                 style: MyConstant().h2Style(),
//               ),
//             ),
            
//             Container(
//               key: formKey,
//                 child: Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
              
//               children: <Widget>[
//                 buildDate(size),
//                 // buildImage(size),
//                 choiceChipWidget(chipList),
                
//               ],
//             )),
//             Padding(
//               padding: EdgeInsets.only(top: 32.0),
//               child: Container(
//                 child: ElevatedButton(
//                   style: MyConstant().MyButtonStyle(),
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                             print('Process Insert to Database');
//                             bookingdate();
//                           }
//                   },
//                   child: Text(
//                     'Book',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//         );
//   }

//   Future<Null> bookingdate() async {
//     String date = dateController.text;
//     print(
//         'date = $date');
//     String path =
//         '${MyConstant.domain}/goalinter_project/getDateWhereDate.php?isAdd=true&date=$date';
//     await Dio().get(path).then((value) {
//       print('value = $value');
//       if (value.toString() == 'null') {
//         print('Have date in my Database');
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("มีการจองแล้วจ้า"),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text("T-T"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//       processInsertMySQL(
//         date : date,
//       );
//     });
//   }

//   Future<Null> processInsertMySQL(
//       {String? id,
//       String? date
//       }) async {
//     print('Success');
//     String apiinsertDate =
//         '${MyConstant.domain}/goalinter_project/insertDate.php?isAdd=true&id=$id&date=$date';
//     await Dio().get(apiinsertDate).then((value) {
//       if (value.toString() == 'true') {
//         Navigator.pop(context);
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("จองไม่สำเร็จ"),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     });
//   }




//   Row buildDate(double size) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//       Container(
//           margin: EdgeInsets.only(top: 20),
//           width: size * 0.8,
//             child: TextFormField(
//             controller : dateController,
//             decoration: const InputDecoration(
//               icon: Icon(Icons.calendar_today),
//               labelText: "Select Date"
//             ),
//             readOnly: true,
//             onTap: (() async{
//               DateTime? pickedDate = await showDatePicker(context: context,
//               initialDate: DateTime.now(),
//               firstDate:DateTime.now(),
//               lastDate: DateTime(2101), 
              
//               );
//               if(pickedDate!=null)
//               {
//                 String formattedDate=DateFormat("dd-MM-yyyy").format(pickedDate);
//                 setState(() 
//                 {
//                   dateController.text=formattedDate.toString();
//                 }
//                 );
//               }
//               else
//               {
//                  print("Not selected");
//               }
//               validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter date';
//               } else {}
//               };
//             }),
//           ),
//           ),
//       ],
//     );
//   }

//     Row buildImage(double size) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 30, bottom: 30),
//           width: size * 0.8,
//           child: ShowImage(
//             path: MyConstant.imagebook,
//           ),
//         ),
//       ],
//     );
//   }


// }

// class choiceChipWidget extends StatefulWidget {
//   final List<String> reportList;

//   choiceChipWidget(this.reportList);

//   @override
//   _choiceChipWidgetState createState() => new _choiceChipWidgetState();
// }

// class _choiceChipWidgetState extends State<choiceChipWidget> {
//   String selectedChoice = "";

//   _buildChoiceList() {
//     List<Widget> choices = [];
//     widget.reportList.forEach((item) {
//       choices.add(Container(
//         padding: const EdgeInsets.all(2.0),
//         child: ChoiceChip(
//           label: Text(item),
//           labelStyle: TextStyle(
//               color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//           backgroundColor: Color(0xffededed),
//           selectedColor: Color.fromARGB(255, 251, 206, 72),
//           selected: selectedChoice == item,
//           onSelected: (selected) {
//             setState(() {
//               selectedChoice = item;
//             });
//           },
//         ),
//       ));
//     });
//     return choices;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }
