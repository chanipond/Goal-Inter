// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfor extends StatefulWidget {
  const AddInfor({Key? key}) : super(key: key);

  @override
  State<AddInfor> createState() => _AddInforState();
}

class _AddInforState extends State<AddInfor> {
  final formKey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<String> paths = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Information'),
          backgroundColor: MyConstant.gray,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildTitle(constraints),
                      buildContent(constraints),
                      buildImage(constraints),
                      buildButtonAdd(constraints),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<Null> chooseImage(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index = $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.imagepic),
          title: ShowTitle(
              title: 'Source Image ${index + 1} ?',
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: 'Please Tab on Camera or Gallery',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chooseImage(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chooseImage(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.5,
          height: constraints.maxWidth * 0.5,
          margin: EdgeInsets.only(top: 20),
          child: file == null
              ? Image.asset(MyConstant.imagepic)
              : Image.file(file!),
        ),
        Container(
          width: constraints.maxWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(0),
                  child: files[0] == null
                      ? Image.asset(MyConstant.imageaddpic)
                      : Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(1),
                  child: files[1] == null
                      ? Image.asset(MyConstant.imageaddpic)
                      : Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(2),
                  child: files[2] == null
                      ? Image.asset(MyConstant.imageaddpic)
                      : Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(3),
                  child: files[3] == null
                      ? Image.asset(MyConstant.imageaddpic)
                      : Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildButtonAdd(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.6,
      child: ElevatedButton(
        style: MyConstant().MyButtonStyle(),
        onPressed: () {
          processButtonAdd();
        },
        child: Text(
          'Add',
          style: MyConstant().h2Style(),
        ),
      ),
    );
  }

  Future<Null> processButtonAdd() async {
    if (formKey.currentState!.validate()) {
      if (formKey.currentState!.validate()) {
        bool checkFile = true;
        for (var item in files) {
          if (item == null) {
            checkFile = false;
          }
        }
        if (checkFile) {
          print('Have image');
          MyConstant().showProgressDialog(context);
          String apisaveInfo =
              '${MyConstant.domain}/goalinter_project/saveInfor.php';

          int loop = 0;
          for (var item in files) {
            int i = Random().nextInt(100000);
            String nameFile = 'information$i.jpg';
            paths.add('/Information/$nameFile');

            Map<String, dynamic> map = {};
            map['file'] =
                await MultipartFile.fromFile(item!.path, filename: nameFile);
            FormData data = FormData.fromMap(map);
            await Dio().post(apisaveInfo, data: data).then((value) async {
                  print('Upload Success');
                  loop++;
                  if(loop >= files.length){

                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    String id = preferences.getString('id')!;
                    String title = titleController.text;
                    String content = contentController.text;
                    String image = paths.toString();
                    print('id = $id');
                    print('title = $title, content = $content');
                    print('image = $image');

                    String path = '${MyConstant.domain}/goalinter_project/insertInformation.php?isAdd=true&id=$id&title=$title&content=$content&image=$image';

                    await Dio().get(path).then((value) => Navigator.pop(context));

                    Navigator.pop(context);
                  }
                  
                });
          }
        } else {
          print('No Image');
          AlertDialog alertDialog = AlertDialog(
            title: ListTile(
              leading: ShowImage(path: MyConstant.imagepic),
              title: ShowTitle(
                  title: 'No Image ?',
                  textStyle: MyConstant().h2Style()),
              subtitle: ShowTitle(
                  title: 'Please Choose Image',
                  textStyle: MyConstant().h3Style()),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        }
      }
    }
  }

  Widget buildTitle(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: titleController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter title';
          } else {}
        },
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Title',
          prefixIcon: Icon(
            Icons.border_color_outlined,
            color: MyConstant.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.error),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
        maxLines: 6,
        controller: contentController,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter title';
        //   } else {}
        // },
        decoration: InputDecoration(
          hintStyle: MyConstant().h3Style(),
          hintText: '   Content',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
