// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:intl/intl.dart';

class Booking_service extends StatefulWidget {
  const Booking_service({Key? key}) : super(key: key);

  @override
  State<Booking_service> createState() => _Booking_serviceState();
}

class _Booking_serviceState extends State<Booking_service> {
  bool _isSelected = false;
  // int tag = 1;
  // List<String> _options = ['Field 1', 'Field 2', 'Field 3'];
  TextEditingController dateController = TextEditingController();

@override
void initState(){
  super.initState();
  dateController.text=" ";
  // defaultChoiceIndex = 0;
 }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text("Booking")),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Form(
              child: ListView(
                children: [
                  buildDate(size),
                  buildImage(size),
                  buildChoicechip(size),
                  buildLogin(size),
                  
                  
                  
                ],
              ),
            ),
          ),
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
            controller : dateController,
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
          margin: EdgeInsets.only(top: 30),
          width: size * 0.8,
          child: ShowImage(
            path: MyConstant.imagebook,
          ),
        ),
      ],
    );
  }

  Row buildChoicechip(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: 
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: <Widget>[
              ChoiceChip(
                backgroundColor: MyConstant.primary,
                label: Text('Field 1'),
                selected: _isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _isSelected = selected;
                  });
                },
              ),
              ChoiceChip(
                backgroundColor: MyConstant.primary,
                label: Text('Field 2'),
                selected: true,
                onSelected: (bool selected) {
                  setState(() {
                    _isSelected = selected;
                  });
                },
              ),
              ChoiceChip(
                backgroundColor: MyConstant.primary,
                label: Text('Field 3'),
                selected: true,
                onSelected: (bool selected) {
                  setState(() {
                    _isSelected = selected;
                  });
                },
              ),
            ],
          ),
          
          // ChoiceChip(
            
          //   backgroundColor: MyConstant.primary,
          //   label: Text('Field 1'),
            
          //   selected: _isSelected,
          //   onSelected: (bool selected) {
          //     setState(() {
          //       _isSelected = selected;
          //     });
          //   },
          // ),
               
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().MyButtonStyle(),
            onPressed: () {
              
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

}
