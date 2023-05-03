// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_title.dart';

class Pay_service extends StatefulWidget {
  const Pay_service({Key? key}) : super(key: key);

  @override
  State<Pay_service> createState() => _Pay_serviceState();
}

class _Pay_serviceState extends State<Pay_service> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: MyConstant.primary, title: Text("Payment")),
      body: SingleChildScrollView(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: buildHead("List Detail")),
                buildTitle("Date: "),
                buildTitle("Time: "),
                buildTitle("Field: \n"),
                myDivider(),
                buildImage(size),
                buildTitle("Account: ชณิภรณ์ เกิดมีทรัพย์ "),
                buildTitle("Amount: 800 Bath"),
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
            child: Image.asset('asset/images/qr.jpg', fit: BoxFit.cover)),
      ],
    );
  }

  Column buildPickPic(double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          
        ),
      ],
    );
  }

  Container buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyConstant.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          print("Confirm");
        },
        child: Text('Confirm'),
      ),
    );
  }
}
