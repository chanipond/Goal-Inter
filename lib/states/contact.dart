import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utillity/my_constant.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class Contact_service extends StatefulWidget {
  const Contact_service({Key? key}) : super(key: key);

  @override
  State<Contact_service> createState() => _Contact_serviceState();
}

class _Contact_serviceState extends State<Contact_service> {
  @override
  Widget build(BuildContext context) {
    final Uri url =
        Uri.parse('https://www.facebook.com/profile.php?id=100047772746105');
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            
            Image.asset('asset/images/facebook.png'),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '\nFacebook : ',
                  style: MyConstant().h2Style(),),
              TextSpan(
                  text: 'สนามฟุตบอลหญ้าเทียม Goal Inter\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(url);
                    }),
            ],
          ),
        ),
        Image.asset('asset/images/contact1.jpg'),
        Text('\nTel: 0870754451', style: MyConstant().h2Style(),),
      ],)),
    );
    //   double size = MediaQuery.of(context).size.width;
    //   return Center(
    //     child: Column(
    //       children: <Widget>[
    //         buildImage(size),
    //         buildFacebook(),
    //         Text('Call: 087-075-4451'),

    //       ],
    //     ),
    //   );
    // }

    //  Row buildImage(double size) {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.only(top: 20, bottom: 10),
    //         width: size * 1,
    //         child: ShowImage(
    //           path: MyConstant.imageface,
    //         ),
    //       ),
    //     ],
    //   );
    // }
    //   Row buildFacebook() {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       ShowTitle(
    //         title: 'Facebook:',
    //         textStyle: MyConstant().h2Style(),
    //       ),
    //        TextButton(
    //         onPressed:  () =>
    //             Navigator.pushNamed(context, MyConstant.routeHome_service),
    //         child: Text(
    //           'สนามฟุตบอลหญ้าเทียม Goal Inter',
    //           style: TextStyle(
    //             fontSize: 16,
    //             // fontWeight: FontWeight.bold,
    //             color: Color.fromARGB(255, 51, 10, 255),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }
  }
}