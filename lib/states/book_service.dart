// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:intl/intl.dart';

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

  String? typeField;

  List<String> time = [
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
    '21:00 - 22:00',
    '22:00 - 23:00',
    '23:00 - 24:00',
  ];


  @override
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

                        value: 'Field3';
                        groupValue: typeField;
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = true;
                          isSelected3 = !isSelected3;
                        });
                        
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ColorFiltered(
                            colorFilter: isSelected3
                            ? ColorFilter.mode(Color.fromARGB(255, 255, 255, 255), BlendMode.saturation)
                            : ColorFilter.mode(Color.fromARGB(0, 200, 18, 18), BlendMode.color),
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
                    SizedBox(
                      height: 460,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: time.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                checktime = true;
                                print('You Click ${time[index]}');
                              },
                              child: Text(time[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildbtnbook(size),
                  ],
                ),
              ),
              

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
                      DateFormat("dd-MM-yyyy").format(pickedDate);
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
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ColorFiltered(
                            colorFilter: isSelected1
                            ? ColorFilter.mode(Color.fromARGB(255, 255, 255, 255), BlendMode.saturation)
                            : ColorFilter.mode(Color.fromARGB(0, 200, 18, 18), BlendMode.color),
                        
                        child: Image.asset(
                          'asset/images/field_book.jpg',
                          fit: BoxFit.cover,
                          
                          
                          
                        )
         ))),
              ),
            ),
            Text("\nField 1\n"),
          ],
        ),

        // Column(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         checkfield = true;
        //         print('You Click Field1');
        //       },
        //       child: Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         margin: EdgeInsets.only(top: 20),
        //         width: size * 0.4,
        //         child: Image.asset(MyConstant.imagefield),
        //       ),
        //     ),
        //     Text("Field 1"),
        //   ],
        // ),

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
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ColorFiltered(
                            colorFilter: isSelected2
                            ? ColorFilter.mode(Color.fromARGB(255, 255, 255, 255), BlendMode.saturation)
                            : ColorFilter.mode(Color.fromARGB(0, 200, 18, 18), BlendMode.color),
                        child: Image.asset(
                          'asset/images/field_book.jpg',
                          fit: BoxFit.cover,
                        )))),
              ),
            ),
            Text("\nField 2\n"),
          ],
        ),

        // Column(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(top: 20),
        //       width: size * 0.4,
        //       child: InkWell(
        //         onTap: () {
        //           checkfield = true;
        //           print('You Click Field2');
        //         },
        //         child: ShowImage(path: MyConstant.imagefield),
        //       ),
        //     ),
        //     Text("\nField 2\n"),
        //   ],
        // ),
      ],
    );
  }

  Row buildbtnbook(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
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
              print('Date = ${dateController.text},Field = , Time = ');
            }

            if (checkfield == true && checkdate == true) {
              print('You Click Book');
              Navigator.pushNamed(context, MyConstant.routePay);
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
}
