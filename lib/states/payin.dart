// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code, unused_element, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:goalinter/utillity/my_constant.dart';
// import 'package:goalinter/widgets/show_image.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class UploadImage extends StatefulWidget {
//   const UploadImage({Key? key}) : super(key: key);
//   final String title = "Upload Image Demo";
//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   File? _image;
//   String status = '';

//   chooseImage(){
//   }
//   startUpload(){}

//   Widget ShowImage(){
//     return Container();
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: MyConstant.primary, title: Text("Booking")),
//       body: Container(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             OutlinedButton(
//               onPressed: () {
//                 chooseImage();
//               },
//               child: Text('Choose Image'),
//              ),
//             SizedBox(height: 20),
//             ShowImage(),
//             SizedBox(height: 20),
//             OutlinedButton(
//               onPressed: () {
//                 startUpload();
//               },
//               child: Text('Upload Image'),
//              ),
//              SizedBox(height: 20),
//              Text(status,
//              style: TextStyle(
//                color: Colors.green,
//                fontWeight: FontWeight.w500,
//                fontSize: 20,
//              ),
//              ),
//           ],
//         ),
//       ),
//     );

//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final formKey = GlobalKey<FormState>();
  File? file;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: MyConstant.primary, title: Text("Booking")),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                } else {
                  print('Process Insert to Database');
                  // booking();
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
}
