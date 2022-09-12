import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_signout.dart';

class Contact_service extends StatelessWidget {
  const Contact_service({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
      body: Center(
        child: 
        Text("Contact us", style: TextStyle(fontSize: 40))),
    );
  }
}
