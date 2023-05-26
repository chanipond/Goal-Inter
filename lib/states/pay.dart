// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/data/booking.dart';
import 'package:goalinter/data/sqlite_model.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/utillity/sqlite_helper.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pay_service extends StatefulWidget {
  const Pay_service({Key? key}) : super(key: key);

  @override
  State<Pay_service> createState() => _Pay_serviceState();
}

class _Pay_serviceState extends State<Pay_service> {
  File? imageField;
  String slip = '';
  int calTime = 0;
  
  

  PrefBooking? prefBooking;
  List<SQLiteModel> sqLiteModels = [];


  @override

  void initState() {
    super.initState();
    processReadSQLite();
    findBooking();
    print('calTime = $calTime');
  }

  Future<Null> processReadSQLite() async {
    await SQLiteHelper().readSQLite().then((value) {
      print('object value ==>> $value');
        setState(() {
          sqLiteModels = value;
        });

    });
  }

  Future<Null> findBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String id_booking = preferences.getString('id_booking')!;
    String id = preferences.getString('id')!;
    print('id = $id');
    String apiGetBooking =
        '${MyConstant.domain}/goalinter_project/getIdbook.php?isAdd=true&id=$id';
    
    await Dio().get(apiGetBooking).then((value) {
      print('value = $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          prefBooking = PrefBooking.fromMap(item);
        });
      }
          print('id_booking = ${prefBooking!.id_booking}');
          print('datetime_start = ${(DateTime.parse(prefBooking!.datetime_start)).toString()}');
          print('datetime_end = ${(DateTime.parse(prefBooking!.datetime_end)).toString()}');
          print('typeField = ${prefBooking!.typeField}');


          String datetime_start = DateTime.parse(prefBooking!.datetime_start).toString();
          String datetime_end = DateTime.parse(prefBooking!.datetime_end).toString();

          DateTime dateStart = DateTime.parse(datetime_start);
          DateTime dateEnd = DateTime.parse(datetime_end);

          calTime = dateEnd.difference(dateStart).inHours;
          if (calTime < 0) {
            calTime = calTime * -1;
          }
          print('calTime = $calTime');
    });
  }

  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(
            backgroundColor: MyConstant.primary, 
            title: Text("Payment"),
            
            ),
      body: SingleChildScrollView(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: buildHead("List Detail")),
                buildTitle("DateTime: " '${prefBooking?.datetime_start}'),
                buildTitle("To " '${prefBooking?.datetime_end}'),
                // buildTitle("Time: " '${prefBooking?.time!=null?(prefBooking?.time??'').substring(1, 8)+(prefBooking?.time??'').substring((prefBooking!.time.length) -7, (prefBooking!.time.length) -1):''}'),
                buildTitle("Field: " '${prefBooking?.typeField}' "\n"),
                myDivider(),
                Center(child: buildHead("Payment")),
                buildImage(size),
                buildTitle("Amount: ${800*calTime}"),
                buildPickPic(size),
                buildbtnpick(),
                buildButton(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Container buildHead(String title) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  Widget myDivider() => Divider(
        color: Color.fromARGB(255, 147, 148, 147),
        height: 1.0,
      );

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            margin: EdgeInsets.only(top: 16),
            width: size * 0.4,
            child: Image.network('https://promptpay.io/0922653849/${(800*calTime).toString()}', fit: BoxFit.cover),
            // child: Image.asset(
            //   'asset/images/qr.jpg', 
            //   fit: BoxFit.cover
              
            // )
            ),
      ],
    );
  }

  Column buildPickPic(double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageField != null)
          Container(
            width: 250,
            height: 300,
            margin: EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(imageField!)),
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
        else
          Container(
              width: 250,
              height: 300,
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'No Slip',
                style: TextStyle(fontSize: 20),
              )),
      ],
    );
  }

  Row buildbtnpick() {
    return Row(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: ElevatedButton(
                onPressed: () => chooseImage(source: ImageSource.camera),
                child: Text(
                  'Camera',
                  style: TextStyle(fontSize: 16),
                ))),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: ElevatedButton(
                onPressed: () => chooseImage(source: ImageSource.gallery),
                child: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 16),
                ))),
      ],
    );
  }

  Container buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyConstant.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (imageField == null) {
            MyConstant()
                .normalDialog(context, 'ไม่มีใบเสร็จ', 'กรุณาเลือกภาพใบเสร็จ');
          } else {
            print("Confirm");
            uploadImage();
          }
        },
        child: Text('Confirm', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  // void getImage({required ImageSource source}) async {
  //   final file = await ImagePicker().pickImage(source: source);

  //   if(file?.path != null){
  //     setState(() {
  //       imageField = File(file!.path);
  //     });
  //   }
  // }

  Future<Null> chooseImage({required ImageSource source}) async {
    try {
      var file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        imageField = File(file!.path);
      });
    } catch (e) {}
  }

  Future uploadImage() async {
    String price = (800*calTime).toString();
    if (imageField == null) {
      insertImageToMySQL();
    } else {
      String apiSaveImage =
          '${MyConstant.domain}/goalinter_project/saveSlip.php';
      int i = Random().nextInt(10000);
      String nameImage = 'slip$i.jpg';
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(imageField!.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveImage, data: data).then((value) {
        slip = '/goalinter_project/slip/$nameImage';
        insertImageToMySQL(
          id_booking: prefBooking?.id_booking,
          id: prefBooking?.id,
          firstname: prefBooking?.firstname,
          lastname: prefBooking?.lastname,
          typeField: prefBooking?.typeField,
          datetime_start: prefBooking?.datetime_start,
          datetime_end: prefBooking?.datetime_end,
          slip: slip,
          price: price,
        );
      });
    }
  }

  Future insertImageToMySQL({
    String? id_booking,
    String? id,
    String? firstname,
    String? lastname,
    String? typeField,
    String? datetime_start,
    String? datetime_end,
    String? slip,
    String? price,
  }) async {
    print('slip => $slip');
    String apiInsertImage =
        '${MyConstant.domain}/goalinter_project/insertSlipping.php?isAdd=true&id_booking=$id_booking&id=$id&firstname=$firstname&lastname=$lastname&typeField=$typeField&datetime_start=$datetime_start&datetime_end=$datetime_end&slip=$slip&price=$price&status=s';
    await Dio().get(apiInsertImage).then((value) {
      if (value.toString() == 'true') {
        print('success');
        Navigator.pushNamedAndRemoveUntil(context, '/member_service', (route) => false);
      } else {
        MyConstant().normalDialog(context, 'Error', 'Please Try Again');
      }

    });
  }

}
