// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goalinter/data/profile.dart';
import 'package:goalinter/utillity/my_constant.dart';
import 'package:goalinter/widgets/show_image.dart';
import 'package:goalinter/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xff73A9AD),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildImage(size),
                buildEmail(size),
                buildPassword(size),
                buildLogin(size),
                buildCreateAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Not a Member?',
          textStyle: MyConstant().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: Text(
            'Register now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff3FA796),
            ),
          ),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
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
                String email = emailController.text;
                String password = pwdController.text;
                print('## email = $email, password = $password');
                checkAuthen(email: email, password: password);
              }
            },
            child: Text(
              'Login',
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

  Future<Null> checkAuthen({String? email, String? password}) async {
    String apiCheckAuthen = '${MyConstant.domain}/goalinter_project/getEmailWhereEmail.php?isAdd=true&email=$email';
    await Dio().get(apiCheckAuthen).then((value) async {
      print('value = $value');
      if (value.toString() == 'null') {
        Fluttertoast.showToast(
            msg: 'No $email in my Database',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        for (var item in json.decode(value.data)) {
          PrefProfile model = PrefProfile.fromMap(item);
          if (password == model.password) {
            // Success Authen
            String userlevel = model.userlevel;
            print('userlevel = $userlevel');

          SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString('id', model.id);
            preferences.setString('userlevel', userlevel);
            preferences.setString('firstname', model.firstname);
            preferences.setString('lastname', model.lastname);

            switch (userlevel) {
              case 'a':
                Navigator.pushReplacementNamed(context, '/admin_service');
                break;
              case 'm':
                Navigator.pushReplacementNamed(context, '/member_service');
                break;
              default:
            }
          } else {
            // Authen False
            Fluttertoast.showToast(
                msg: 'Password False',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      }
    });
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          width: size * 0.6,
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter email';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
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
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: size * 0.6,
          child: TextFormField(
            controller: pwdController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              } else {
                return null;
              }
            },
            obscureText: statusRedEye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                        color: MyConstant.dark,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dark,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.vpn_key_outlined,
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
            ),
          ),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: size * 0.6,
          child: ShowImage(
            path: MyConstant.image1,
          ),
        ),
      ],
    );
  }
}
