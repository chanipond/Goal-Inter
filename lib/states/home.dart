import 'package:flutter/material.dart';
import 'package:goalinter/states/booking_service.dart';

import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';

class Home_service extends StatefulWidget {
  const Home_service({Key? key}) : super(key: key);

  @override
  State<Home_service> createState() => _Home_serviceState();
}

class _Home_serviceState extends State<Home_service> {
  @override
  Widget build(BuildContext context) {
    // double size = MediaQuery.of(context).size.width;
    // return Scaffold(
    //     body: Center(
    //         child: Form(
    //             child: SingleChildScrollView(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       buildImage(size),
    //       Text("Home naja"),
    //     ],
    //   ),
    // ))));
  // }

  // Row buildImage(double size) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(top: 80),
  //         width: size * 1,
  //         child: ShowImage(
  //           path: MyConstant.imagehome,
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }

    return Scaffold(
        body: Center(
          child: Image.asset('asset/images/Goal2.jpg'),
        ),
              
    );
  }
}