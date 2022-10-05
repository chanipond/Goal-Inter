import 'dart:convert';
import 'package:email_validator/email_validator.dart';
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
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  
  Future register() async{
    // var url = ;
    var response = await http.post(
      Uri.parse("http://10.34.5.76/goalinter_project/register.php"), 
      body: {
      "firstname" : nameController.text,
      "lastname" : lastController.text,
      "telephonenumber" : telController.text,
      "email" : emailController.text,
      "password" : pwdController.text,
    });

    var data = json.decode(response.body);
    if (data == "Error"){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Failed to register"),
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
      // Fluttertoast.showToast(
      //   msg: "Failed to register",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
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
              TextButton(
                child: Text("OK"),
                onPressed: 
                  () => Navigator.pushNamed(context, MyConstant.routeAuthen),
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
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Firstname';
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
            keyboardType: TextInputType.emailAddress,
            validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Please enter a valid email'
              : null,
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return 'Please enter Email';
            //   } else {}
            // },
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

  // Future<Null> InsertData() async {
  //   String firstname = firstController.text;
  //   String Lastname = lastController.text;
  //   String Telephone = telController.text;
  //   String Email = emailController.text;
  //   String Password = pwdController.text;

  //   print(
  //       '## firstname = $firstname, lastname = $Lastname, telphone = $Telephone, email = $Email, password = $Password');
  //   String path =
  //       '${MyConstant.domain}/goalinter_project/getfirstWherefirst.php?isAdd=true&firstname=$firstname';
  //   await Dio().get(path).then((value) async {
  //     print('## value ==>> $value');
  //     if (value.toString() == 'null') {
  //       print('## first ok');
  //       // if(file == null){
  //       //   processInsertMySQL(
  //       //     firstname: firstname,
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
  //           .normalDialog(context, 'first Already!!', 'Please Change first');
  //     }
  //   });
  // }

  // Future<Null> processInsertMySQL(
  //     {String? firstname,
  //     String? lastname,
  //     String? telephonenumber,
  //     String? email,
  //     String? password}) async {
  //   String apiInsertfirst =
  //       '${MyConstant.domain}/goalinter_project/insertfirst.php?isAdd=true&firstname=$firstname&lastname=$lastname&telephonenumber=$telephonenumber&email=$email&password=$password';
  //   await Dio().get(apiInsertfirst).then((value) {
  //     if (value.toString() == 'true') {
  //       Navigator.pop(context, MyConstant.routeAuthen);
  //     } else {
  //       MyDialog().normalDialog(
  //           context, 'Create New first False😭', 'Please Try Again');
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
