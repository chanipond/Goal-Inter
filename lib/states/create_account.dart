// ignore_for_file: prefer_const_constructors, prefer_void_to_null, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goalinter/utillity/my_constant.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController conpwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter firstname';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Firstname',
              prefixIcon: Icon(
                Icons.accessibility_new_rounded,
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

  Row buildLastName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: lastController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter lastname';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Lastname',
              prefixIcon: Icon(
                Icons.accessibility_new_rounded,
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

  Row buildTelNumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: telController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter telephone number';
              } else if(value.length !=10)
               {
                return 'Should be at least 10 digits';
               }
               else {}
            },
            maxLength: 10,
              decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Telephone Number',
              prefixIcon: Icon(
                Icons.phone_android,
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

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Please enter a valid email'
                    : null,
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
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: pwdController,
            maxLength: 8,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              } else {}
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

  Row buildConfirmPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: conpwdController,
            maxLength: 8,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter confirm password';
              }
              if ( pwdController.text != conpwdController.text) {
                return 'Password not match';
              } else {}
            },
            obscureText: true,
            decoration: InputDecoration(
              // suffixIcon: IconButton(
              //   onPressed: () {
              //     setState(() {
              //       statusRedEye = !statusRedEye;
              //     });
              //   },
              //   icon: statusRedEye
              //       ? Icon(
              //           Icons.remove_red_eye,
              //           color: MyConstant.dark,
              //         )
              //       : Icon(
              //           Icons.remove_red_eye_outlined,
              //           color: MyConstant.dark,
              //         ),
              // ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'Confirm Password',
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

  Future<Null> register() async {
    String firstname = nameController.text;
    String lastname = lastController.text;
    String telephonenumber = telController.text;
    String email = emailController.text;
    String password = pwdController.text;
    print(
        'name = $firstname, lastname = $lastname, telephonenumber = $telephonenumber, email = $email, password = $password');
    String path =
        '${MyConstant.domain}/goalinter_project/getEmailWhereEmail.php?isAdd=true&email=$email';
    await Dio().get(path).then((value) {
      print('value = $value');
      if (value.toString() == 'null') {
        print('Have email in my Database');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("This account has been used"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      processInsertMySQL(
        firstname : firstname,
        lastname : lastname,
        telephonenumber : telephonenumber,
        email: email,
        passwordenc : password,
      );
    });
  }

  Future<Null> processInsertMySQL(
      {String? firstname,
      String? lastname,
      String? telephonenumber,
      String? email,
      String? passwordenc}) async {
    // print('Success');
    String apiinsertUser =
        '${MyConstant.domain}/goalinter_project/insertUser.php?isAdd=true&firstname=$firstname&lastname=$lastname&telephonenumber=$telephonenumber&email=$email&password=$passwordenc&userlevel=m';
    await Dio().get(apiinsertUser).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // buildTitle1(),
                buildName(size),
                buildLastName(size),
                buildTelNumber(size),
                buildEmail(size),
                buildPassword(size),
                buildConfirmPassword(size),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: size * 0.6,
                      child: ElevatedButton(
                        style: MyConstant().MyButton2Style(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('Process Insert to Database');
                            register();
                          }
                        },
                        child: Text(
                          'Register',
                          style: MyConstant().h3Style(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
