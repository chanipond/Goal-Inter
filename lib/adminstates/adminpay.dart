// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/adminstates/adminbooking.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adminpay extends StatefulWidget {
  const Adminpay({Key? key}) : super(key: key);

  @override
  State<Adminpay> createState() => _AdminpayState();
}

class _AdminpayState extends State<Adminpay> {
  final formKey = GlobalKey<FormState>();
  String slip = '';
  List<File> files = [];
  File? file;
  String? date = datetest;
  String? time = timetest;
  String? typeField = fieldtest;
  PrefBooking? booking;

  @override
  void initState() {
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: MyConstant.gray, title: Text("Booking")),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle("Date: $date "),
                buildTitle("Time: $time "),
                buildTitle("Field: $typeField "),
                buildTitle("Promtpay : 0870754451"),
                buildTitle("Price : 800 Bath"),
                buildTitle("Upload payment receipt"),
                buildslip(size),
                buildbook(size)
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Row buildslip(double size) {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => chooseImage(ImageSource.camera),
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        size: 30,
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: size*0.5,
                    child: file == null
                        ? ShowImage(path: MyConstant.imagepay)
                        : Image.file(file!),
                  ),
                  IconButton(
                      onPressed: () => chooseImage(ImageSource.gallery),
                      icon: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 30,
                      )),
                ],
              );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
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
              if (formKey.currentState!.validate()) {
                if (file == null) {
                  print('non choose payment receipt');
                  

                  MyConstant().normalDialog(
                      context, '❌❌❌', 'Please choose payment receip');
                  processInsertMySQL();
                } else {
                  print('Process Insert to Database');
                  uploadPicture();
                  Navigator.pushReplacementNamed(context, '/admin_service');
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

  Future<Null> uploadPicture() async {
  //   String apisaveSlip = '${MyConstant.domain}/goalinter_project/saveSlip.php';
  //   int i = Random().nextInt(100000);
  //   String nameFile = 'slip$i.jpg';
  //   Map<String, dynamic> map = Map();
  //   map['file'] = await MultipartFile.fromFile(file!.path,filename: nameFile);
  //   FormData data = FormData.fromMap(map);
  //   await Dio().post(apisaveSlip, data: data).then((value) {
  //   print('value = $value');
  //   slip = '/goalinter_project/slip/$nameFile';
  // });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    String path =
        '${MyConstant.domain}/goalinter_project/getidbookWhereid.php?isAdd=true&id=$id&status=w';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        if (file == null) {
          // No picture
        } else {
          // Have picture
          String apisaveSlip = '${MyConstant.domain}/goalinter_project/saveSlip.php';
          int i = Random().nextInt(100000);
          String nameSlip = 'slip$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              await MultipartFile.fromFile(file!.path, filename: nameSlip);
          FormData data = FormData.fromMap(map);
          await Dio().post(apisaveSlip, data: data).then((value) {
            slip = '/goalinter_project/slip/$nameSlip';
            processInsertMySQL();
          });
        }
      } else {
        print('false');
      }
    });
  }
  
  Future<Null> processInsertMySQL() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     String id_booking = preferences.getString('id_booking')!;
     String slip = preferences.getString('slip')!;
    //String id = preferences.getString('id')!;
    print('Work processInsertMySQL');
    String apiInsertUser =
        '${MyConstant.domain}/goalinter_project/insertSlip.php?isAdd=true&id_booking=$id_booking&slip=$slip&status=cf';
    await Dio().get(apiInsertUser).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        MyConstant().normalDialog(context, '❌❌❌', 'Fail');
      }
    });
  }

}
