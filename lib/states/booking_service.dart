import 'dart:ffi';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:intl/intl.dart';

class Booking_service extends StatefulWidget {
  const Booking_service({Key? key}) : super(key: key);

  @override
  State<Booking_service> createState() => _Booking_serviceState();
}

class _Booking_serviceState extends State<Booking_service> {
TextEditingController dateController=TextEditingController();

@override
void initState(){
  super.initState();
  dateController.text="";
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text("Booking")),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(child: TextField(
            controller:dateController,
            
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Select Date"
            ),
            readOnly: true,
            onTap: (() async{
              DateTime? pickedDate=await showDatePicker(context: context,
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
          )),
        ),
    );
  }
}
