import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goalinter/utillity/my_constant.dart';
// import 'package:goalinter/utillity/my_dialog.dart';
// import 'package:goalinter/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // String? sedlectpwd;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  
  Future register() async{
    // var url = ;
    var response = await http.post(
      Uri.parse("http://10.0.0.74/goalinter_project/register.php"), 
      body: {
      "username" : userController.text,
      "lastname" : lastController.text,
      "telephonenumber" : telController.text,
      "email" : emailController.text,
      "password" : pwdController.text,
    });

    var data = json.decode(response.body);
    if (data == "Error"){
      Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }else{
      // Fluttertoast.showToast(
      //   msg: "Registration Successful",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Register Success"),
            actions: <Widget>[
              FlatButton(
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
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Username';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Username',
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
                return 'Please enter Lastname';
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
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Telephone Number';
              } else {}
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Email';
              } else {}
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
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: pwdController,
            maxLength: 8,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Password';
              } else {}
            },
            decoration: InputDecoration(
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

  // Future<Null> InsertData() async {
  //   String Username = userController.text;
  //   String Lastname = lastController.text;
  //   String Telephone = telController.text;
  //   String Email = emailController.text;
  //   String Password = pwdController.text;

  //   print(
  //       '## username = $Username, lastname = $Lastname, telphone = $Telephone, email = $Email, password = $Password');
  //   String path =
  //       '${MyConstant.domain}/goalinter_project/getUserWhereUser.php?isAdd=true&username=$Username';
  //   await Dio().get(path).then((value) async {
  //     print('## value ==>> $value');
  //     if (value.toString() == 'null') {
  //       print('## user ok');
  //       // if(file == null){
  //       //   processInsertMySQL(
  //       //     username: Username,
  //       //     lastname: Lastname,
  //       //     telephonenumber: Telephone,
  //       //     email: Email,
  //       //     password: Password,
  //       //   );
  //       // } else {
  //       //   print('### what');
  //       // }
  //     } else {
  //       MyDialog()
  //           .normalDialog(context, 'User Already!!', 'Please Change User');
  //     }
  //   });
  // }

  // Future<Null> processInsertMySQL(
  //     {String? username,
  //     String? lastname,
  //     String? telephonenumber,
  //     String? email,
  //     String? password}) async {
  //   String apiInsertUser =
  //       '${MyConstant.domain}/goalinter_project/insertUser.php?isAdd=true&username=$username&lastname=$lastname&telephonenumber=$telephonenumber&email=$email&password=$password';
  //   await Dio().get(apiInsertUser).then((value) {
  //     if (value.toString() == 'true') {
  //       Navigator.pop(context, MyConstant.routeAuthen);
  //     } else {
  //       MyDialog().normalDialog(
  //           context, 'Create New User False😭', 'Please Try Again');
  //     }
  //   });
  // }

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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // color: Colors.black,
                          ),
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


