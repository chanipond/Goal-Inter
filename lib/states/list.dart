import 'package:flutter/material.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';

class List_service extends StatefulWidget {
  const List_service({Key? key}) : super(key: key);

  @override
  State<List_service> createState() => _List_serviceState();
}

class _List_serviceState extends State<List_service> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildImage(size),
          Text(
            "Empty",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          width: size * 0.6,
          child: ShowImage(
            path: MyConstant.image1,
          ),
        ),
      ],
    );
  }
}
