import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';
import 'my_constant.dart';

class MyDialog {
  Future<Null> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().h3Style()),
        ),
        actions: [TextButton(onPressed: () {}, child: Text('OK'))],
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().h3Style()),
        ),
        children: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }

//   Future<Null> actionDialog(
//     BuildContext context,
//     String title,
//     String message,
//   ) async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: ListTile(
//           leading: ShowImage(path: MyConstant.image1),
//           title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
//           subtitle:
//               ShowTitle(title: message, textStyle: MyConstant().h3Style()),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: Text('OK'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }
}
