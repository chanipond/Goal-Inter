import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goalinter/widgets/show_image.dart';

class Info_service extends StatefulWidget {
  const Info_service({Key? key}) : super(key: key);

  @override
  State<Info_service> createState() => _Info_serviceState();
}

class _Info_serviceState extends State<Info_service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text("Information"),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 80),
            child: Center(
              child: ListView(
                children: <Widget>[
                  CarouselSlider(
                    items: [
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play4.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play5.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play6.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play7.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('asset/images/play8.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 250.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 400),
                    ),
                  ),
                  Text(
                    "\n16 ธันวาคม 2018",
                    style: MyConstant().h3Style(),
                  ),
                  Text(
                    "\nSingha Junior Cup",
                    style: MyConstant().h1Style(),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
