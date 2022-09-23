import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Field_service extends StatefulWidget {
  const Field_service({Key? key}) : super(key: key);

  @override
  State<Field_service> createState() => _Field_serviceState();
}

class _Field_serviceState extends State<Field_service> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyConstant.primary,
//         title: Text("Information"),
//       ),
//     );
//   }
// }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text("Goal-Inter Football Field"),
      ),
      body: Container(
        child: Center(child: ListView(
          children: <Widget>[
        CarouselSlider(items: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
            image : DecorationImage(
              image: AssetImage('asset/images/contact1.jpg'),
              fit: BoxFit.cover,
              ), 
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
            image : DecorationImage(
              image: AssetImage('asset/images/Goal1.jpg'),
              fit: BoxFit.cover,
              ), 
            ),
          )
        ], 
        options: CarouselOptions(
          height: 500.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 16/9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 400),
        ),
        )
      ],
      ),
        )), 
    );
  }
}
